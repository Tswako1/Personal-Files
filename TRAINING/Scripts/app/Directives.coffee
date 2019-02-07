 
angular.module('mipmis').directive("date", ['dateFilter', '$parse', '$timeout', (dateFilter, $parse, $timeout)  ->
  restrict: "CA"
  priority: -1
  link: (scope, element, attributes) ->
    unwatch = scope.$watch(attributes.ngModel , (value)-> 
                                               $parse(attributes.ngModel).assign(scope,dateFilter( value,'yyyy/MM/dd'))
                                               #unwatch()
                                               )
    element.datepicker(format: "yyyy/mm/dd", autoclose: true)
      .on("changeDate",(e)-> 
                             #if e.viewMode != "days" then return
                             scope.$apply -> 
                                $parse(attributes.ngModel).assign(scope,dateFilter( e.date,'yyyy/MM/dd'))
                                element.focus()
                                element.datepicker("hide"))
    #scope.$on("focus",-> element.datepicker("hide"))

]
)

angular.module('mipmis').directive( 'mycurr', [ '$filter', '$parse',($filter, $parse) ->
  {
    require: 'ngModel'
    restrict: 'A'
    link: (scope, element, attrs, ngModel) ->

      parse = (viewValue, noRender) ->
        if !viewValue
          return viewValue
        # strips all non digits leaving periods.
        clean = viewValue.toString().replace(/[^0-9.]+/g, '').replace(/\.{2,}/, '.')
        # case for users entering multiple periods throughout the number
        dotSplit = clean.split('.')
        if dotSplit.length > 2
          clean = dotSplit[0] + '.' + dotSplit[1].slice(0, 2)
        else if dotSplit.length == 2
          clean = dotSplit[0] + '.' + dotSplit[1].slice(0, 2)
        if !noRender
          ngModel.$render()
        clean

      ngModel.$parsers.unshift parse

      ngModel.$render = ->
        console.log 'viewValue', ngModel.$viewValue
        console.log 'modelValue', ngModel.$modelValue
        clean = parse(ngModel.$viewValue, true)
        if !clean
          element.val clean
          return
        currencyValue = undefined
        dotSplit = clean.split('.')
        # todo: refactor, this is ugly
        if clean[clean.length - 1] == '.'
          currencyValue = $filter('number')(parseFloat(clean)) + '.'
        else if clean.indexOf('.') != -1 and dotSplit[dotSplit.length - 1].length == 1
          currencyValue = $filter('number')(parseFloat(clean), 1)
        else if clean.indexOf('.') != -1 and dotSplit[dotSplit.length - 1].length == 1
          currencyValue = $filter('number')(parseFloat(clean), 2)
        else
          currencyValue = $filter('number')(parseFloat(clean))
        element.val currencyValue
        return

      return

  }
]
)
angular.module('mipmis').directive 'toggle', [ ->
    restrict: 'A'
    template: '<button ng-click="toggle = !toggle"></button>'
    replace: true,
    scope: toggle: '='
]


angular.module('mipmis').directive("ngModel", ['$rootScope', ($rootScope)  ->
  restrict: "A"
  link: (scope, element, attributes) ->
    messages=
        currency: "This field requires a valid currency amount. Please enter an amount in one of the following formats: 123456.78, 123 456.67"
        numeric: "This field requires a valid number."
        date: "This field requires a valid date."
        percentage: "This field requires a valid percentage."
 
    element.after($("<div class='error'></div>").attr("validation-message",attributes.validationmessage||messages[attributes.fieldtype]||"This field does not have a valid value."))
    element.blur(-> element.addClass('blurred'))
    element.focus(-> $rootScope.$broadcast("focus",element))
]
)

documentManagementController= ['$scope','$document', 'documentType','foreignId','foreignType','documents','$http','parentScope','documentTypes','title','close', ($scope,$document,documentType,foreignId,foreignType,documents,$http,parentScope,documentTypes,title,close)->
    queue = null
    adding = false
    $scope.close = close
    $scope.documentType = documentType
    $scope.foreignId = foreignId
    $scope.foreignType = foreignType
    $scope.options = url: 'upload/fileHandler'  
    $scope.documents =  documents.data
    $scope.adddocument = ($event) ->
        $event.stopPropagation()
        $('#add-file').click()
    $document.on 'click', (event) ->  
        if(event.target == $('.modal.fade.in')[0])          
            $document.off 'click'
            close.value.close()

    $scope.setqueue = (myQueue)->
        queue = myQueue
    $scope.increment = ->
        parentScope.numberOfDocuments = documents.data.length + queue.length
    $scope.now = Date.now()
    $scope.deletedocument = (document) ->
        $http.delete("api/document/#{document.id}" ).then( -> 
            documents.data.splice(documents.data.indexOf(document),1)
            parentScope.numberOfDocuments-- )
    $scope.documentTypeName = title || documentTypes.data.filter((x) -> x.id == documentType)[0].description
]
                
angular.module('mipmis').directive("documentManagement", ['$rootScope', ($rootScope)  ->
    controller: ['$scope','$modal','$element', ($scope,$modal,$element)->
        $scope.open=(documentType,foreignId,foreignType,title)->
            close = {}
            close.value = $modal.open 
                templateUrl: "content/views/documentUpload.html"
                controller: documentManagementController
                resolve:
                    documents: ['$http',($http) -> $http.get "api/document/?documentType=#{documentType}&foreignId=#{foreignId}&foreignType=#{foreignType}"]
                    documentType: ->
                        documentType
                    foreignId: ->
                        foreignId
                    foreignType: ->
                        foreignType
                    parentScope: ->
                        $scope
                    documentTypes: ['$http', ($http) -> $http.get "lookup/DocumentTypes"]
                    title: -> title
                    close: -> close
    ]
    restrict: "C"
    link: (scope, element, attributes) ->
        f = 1
    template: "<span class='project-documents' ng-click='open(documentType(),foreignId(),foreignType(),documentTitle)'>
                <a  href=''><i class='icon-cabinet'></i>
                <span ng-hide='numberOfDocuments==0' class='badge'>{{numberOfDocuments}}</span>
                </a>
                </span>"
    replace: true
    scope:  
        numberOfDocuments: "=documentCount"
        foreignId: "&foreignId"
        foreignType: "&foreignType"
        documentType: "&documentType"
        documentTitle: "@"
]
)
angular.module('mipmis').directive "select2", ['$timeout', ($timeout) ->
  restrict: "A"

  link: (scope, element, attributes) ->
    scope.$watch(attributes.data,(value) -> 
        if value then $timeout -> 
            element.select2())
    #        element.val(value.data.map((x) -> x.id))))
    
]

angular.module('mipmis').directive("form", ->
  restrict: "E"
  link: (scope, element, attributes) ->
    element.bind("submit",-> element.addClass('submitted'))
)

angular.module('mipmis').directive("lookup", ['$http',($http) ->
    restrict: "A"
    scope: id: "=id"
    link: (scope, element, attributes) ->
        $http.get('lookup/'+attributes.lookup).then((response)->
            values = response.data.filter((x)->x.id == scope.id)
            if(values.length > 0)
                element.text(values[0].description))
]
)    

angular.module('mipmis').directive("yesno", ['$http',($http) ->
    restrict: "A"
    link: (scope, element, attributes) ->
        if attributes.yesno == "true" then value = "Yes" else value = "No"
        element.text(value)
            
]
)    

angular.module('mipmis').directive("condition", ['$http',($http) ->
    restrict: "A"
    link: (scope, element, attributes) ->
        if attributes.condition == "1" then element.addClass('One') else if attributes.condition == "2" then element.addClass('Two') else if attributes.condition == "3" then element.addClass('Three') else if attributes.condition == "4" then element.addClass('Four') else if attributes.condition == "5" then element.addClass('Five')   
]
)    

angular.module('mipmis').filter 'periodNumberAsText', -> 
    months = 
        1: 'Jul'
        2: 'Aug'
        3: 'Sep'
        4: 'Oct'
        5: 'Nov'
        6: 'Dec'
        7: 'Jan'
        8: 'Feb'
        9: 'Mar'
        10: 'Apr'
        11: 'May'
        12: 'Jun'
    (x) -> months[x]

angular.module('mipmis').filter 'financialYear', -> 
    (x) -> parseInt(x) - 1 + '/' + x.substring(2)


angular.module('mipmis').factory 'breadcrumb', ['$rootScope', '$route', '$location', ($rootScope, $route, $location) ->
    (crumbs) -> 
        $rootScope.breadcrumbs = ( {description: x.description, url: x.url || $location.$$url } for x in crumbs)
]


angular.module('mipmis').directive 'placeholder', ['$rootScope', ($rootScope) ->
    restrict: 'A'
    link: (scope, element, attrs) -> 
        $rootScope.$on "$routeChangeStart", (event) ->
            element.html ''

        $rootScope.$on "placeholder:#{attrs.placeholder}", (event, content) ->
            element.html ''
            element.append content
]


angular.module('mipmis').directive 'placeholderContent', [ ->
    restrict: 'A'
    transclude: true,
    compile: (element, attrs, transclude) -> 
        (scope) -> 
            transclude scope, (clone) ->
                scope.$emit "placeholder:#{attrs.placeholderContent}", clone
]

angular.module('mipmis').directive 'chart', ['$http', ($http) ->
    restrict: 'A'
    template: '<div><svg height="300px"></svg></div>'
    scope: values: '='
    link: (scope, element, attrs) -> 
        actualDate = (year, period) ->
            if period < 7 then new Date(year, period + 6, 1) else new Date(year +  1, period - 6, 1) 
    
        
        xs = scope.values.projectBudgets.groupBy (x) -> actualDate(x.financialYear, x.financialPeriod).toISOString()
    
        actualValues = scope.values.projectActuals.reduce (a, b, i) -> 
            a.concat(x: actualDate(b.financialYear, b.financialPeriod), y: b.amount + a[a.length-1].y)
        , [{ x: 0, y: 0}] 

        budgetValues = xs.reduce (a, b, i) -> 
            a.concat(x: new Date(b.key), y: b.value.reduce(((y1, y2) -> y1 + y2.amount), 0) + a[a.length-1].y)
        , [{ x: 0, y: 0}] 
        
        actuals = key: 'Actuals', values: actualValues[1..]
        budgets = key: 'Budgets', color: "red" , values: budgetValues[1..]
        
        data = [actuals, budgets]
        
        chart = nv.addGraph ->  
            el = element.find('svg')[0]
            #el = "#chart"
        
            chart = nv.models.lineChart();
 
            chart.xAxis.axisLabel('Period')
                       .tickFormat (d) -> d3.time.format('%Y/%m')(new Date(d))
  
            chart.yAxis.axisLabel('Amount (R)')
                       .tickFormat(d3.format('R d'))
 
            d3.select(el).datum(data)
                         .transition()
                         .duration(500)
                         .call(chart);
            
            #nv.utils.windowResize () -> d3.select(el).call(chart)
            
            chart;
]


angular.module('mipmis').factory 'operation', [ ->
    operations = {} 
    access.map (x) -> operations[x] = true 
    return (x) -> operations[x]
]

angular.module('mipmis').directive 'operation', [ ->
    operations = {} 
    access.map (x) -> operations[x] = true 
    
    restrict: 'A'
    link: (scope, element, attrs) ->
        if(!operations[attrs.operation])
            element.remove()
]

angular.module('mipmis').directive 'bulletChart', [ ->
    restrict: 'A'
    link: (scope, element, attrs) ->
        measures = scope.$eval(attrs.measures)
        markers = scope.$eval(attrs.markers)
        nv.addGraph ->  
            chart = nv.models.bulletChart()
            d3.select(element[0])
              .datum(title: scope.$eval(attrs.description), ranges: [0, Math.max(measures, markers) * 1.1], measures: [measures], markers: [markers])
              .transition().duration(1000)
              .call(chart)
]


angular.module('mipmis').directive "mipmisAccordion", [() ->
  restrict: "A"
  #transclude: true
  controller: ['$scope', ($scope) ->
    sections = $scope.sections = []
    current = null
    @add = (section) ->
        if sections.length == 0 
            section.expanded = true 
            current = section
        sections.push section
    @expand = (section) ->
        section.expanded = true
        current.expanded = false
        current = section
  ]
  link: (scope, element, attributes) ->
  
]

angular.module('mipmis').directive "accordionSection", [() ->
    restrict: "A"
    require: '^mipmisAccordion'
    transclude: true
    replace: true
    template: '<li ng-class="{expanded: expanded}"><h4 ng-click="expand()"><a href="{{href}}">{{description}}</a></h4><div ng-transclude></div></li>'
    scope: description: '@accordionSection', href: '@'
    link: (scope, element, attributes, accordion) ->
        accordion.add scope  
        scope.expand = -> 
            accordion.expand scope
]


angular.module('mipmis').directive 'calendar', ['$compile', ($compile) ->
    restrict: 'A'
    replace: true
    link: (scope, elm, attrs) ->
        today = new Date()        
        year = today.getFullYear()
        month = today.getMonth()
    
        render = (year, month) ->
            elm.html('')
            months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
            start = new Date(year, month, 1)
            stop = d3.time.month.offset(start, 1)
            
            if start.getDay() != 1
                start = d3.time.day.utc.offset(start, -1 * ((if start.getDay() == 0 then 7 else start.getDay()) - 1))
            days = d3.time.day.utc.range(start, stop)

            nextYear = -> if month < 11 then year else year + 1
            nextMonth = -> if month < 11 then month + 1 else 0
            prevYear = -> if month > 0 then year else year - 1
            prevMonth = -> if month > 0 then month - 1 else 11

            table = d3.select(elm[0])
                            .append('table')
                            .attr('class', 'month')
            header = table.append('thead').append('tr')
            header.append('th')
                    .attr('class', 'back')
                    .append('button')
                        .on('click', -> scope.$eval(attrs.monthChange)(prevYear(), prevMonth(), -> render(prevYear(), prevMonth())))
            header.append('th')
                     .attr('colspan', '5')
                     .text(months[month] + ' ' + year)
            header.append('th')
                    .attr('class', 'forward')
                    .append('button')
                        .on('click', -> scope.$eval(attrs.monthChange)(nextYear(), nextMonth(), -> render(nextYear(), nextMonth())))

            table.append('tbody')
                    .selectAll('tr')
                        .data(days.filter (x) -> x.getDay() == 1)
                        .enter().append('tr')
                            .selectAll('td')
                            .data((d) -> d3.time.day.utc.range(d, d3.time.day.offset(d, 7)))
                            .enter().append('td')
                                    .on('click', (d) -> scope.$apply -> scope.$eval(attrs.select)(d))
                                    .attr('pop', (d) -> d)
                                    .attr('class', (d) -> if d.getMonth() == month then scope.$eval(attrs.callback)(d) else "")
                                    .text((d) -> if d.getMonth() == month then d.getDate() else "")
            $compile(table[0])(scope)

        attrs.$observe('callback', -> render(year, month));
]
angular.module('mipmis').directive 'node', [ ->
    loading = true
    restrict: 'A'
    transclude: true
    replace: true
    scope: {value: '@', label: '@',organisations: '='}
    required: 'node'
    controller: ['$scope','$element','$timeout', ($scope,$element,$timeout)->
        children = []
        $scope.state = 'none'
        if $scope.value && $scope.organisations && $scope.organisations.indexOf($scope.value) >= 0
            $scope.state = 'all'
        else
            $scope.state = 'none'
        @add = (child) ->
            $scope.hasChildren = true
            children.push(child)
            child.$watch 'state', (val) -> 
               return if busy
               noSelectedChildren = children.filter((x)->x.state == 'none').length
               allSelectedChildren = children.filter((x)->x.state == 'all').length
               if noSelectedChildren == children.length
                    if loading then $scope.collapsed = true
                    $scope.state = 'none'
               else if allSelectedChildren == children.length
                    if loading then $scope.collapsed = false
                    $scope.state = 'all'
               else
                    if loading then $scope.collapsed = false
                    $scope.state = 'some'
                     
        busy = false
        $scope.setStatus = (newState) ->
            busy = true
            $scope.state = newState   
            child.setStatus($scope.state) for child in children
            if $scope.value && newState == 'all' && $scope.organisations.indexOf($scope.value) < 0
                $scope.organisations.push($scope.value)
            if $scope.value && newState == 'none' && $scope.organisations.indexOf($scope.value) >= 0
                $scope.organisations.splice($scope.organisations.indexOf($scope.value),1)
            busy = false
        $scope.click = ->
            loading = false
            if $scope.state == 'none'
                $scope.setStatus('all') 
            else if $scope.state == 'all'
                $scope.setStatus('none') 
            else if $scope.state == 'some'
                $scope.setStatus('all') 
    ]   
    template: '<li ng-class="{leaf: !hasChildren, collapsed: collapsed}"><button class="expanded" toggle="collapsed"></button><button class="state" ng-class="state" ng-click="click()"></button><div ng-transclude></div></li>'
    link: (scope, element, attrs, node ) ->
        parent = element.parent().controller('node')
        if parent then parent.add(scope)
                    
]

angular.module('mipmis').directive 'popup', ['$document', '$rootScope', 'localStorageService', ($document, $rootScope, localStorageService) ->
    transclude: true,
    template:  '<div>
                    <a href="" class="glyphicon glyphicon-user user-menu" ng-click="toggle($event)"/>
                </div>
                <div class="user-options" ng-show="isOpen" ng-click="$event.stopPropagation()">
                    <div class="triangle"></div>
                    <div ng-transclude></div>
                    <div style="position: absolute; bottom: 10px; left: 10px" ng-hide="change">
                        <button class="btn btn-default" ng-click="dismiss()">Dismiss</button>
                    </div>
                 </div>'        
    scope: {change: '='}
    link: ($scope, $element, $attrs) ->
        $scope.isOpen  = !localStorageService.get('welcome.dismissed')
        $scope.dismiss = ->
            $scope.isOpen = false
            localStorageService.add('welcome.dismissed', true)
        $scope.toggle = ($event) ->
            $event.stopPropagation();
            $scope.isOpen = !$scope.isOpen
        $document.on 'click', (event) ->                        
            if $scope.isOpen and !$rootScope.$$phase 
                $scope.$apply -> $scope.isOpen = false
]

angular.module('mipmis').directive 'fieldinfo', ['$document', '$rootScope', 'localStorageService', ($document, $rootScope, localStorageService) ->
    template: '''<div class="glyphicon glyphicon-info-sign user-menu" ng-click="toggle($event)"><div ng-include="'content/information/' + file + '.htm'" ng-show="isOpen"></div></div>'''        
    scope: true
    link: ($scope, $element, $attrs) ->
        $scope.file = $attrs.fieldinfo
        $scope.isOpen  = !localStorageService.get('welcome.dismissed')
        $scope.dismiss = ->
            $scope.isOpen = false
            localStorageService.add('welcome.dismissed', true)
        $scope.toggle = ($event) ->
            $event.stopPropagation();
            $scope.isOpen = !$scope.isOpen
        $document.on 'click', (event) ->                        
            if $scope.isOpen and !$rootScope.$$phase 
                $scope.$apply -> $scope.isOpen = false
]

angular.module('mipmis').directive 'coordinate', ['$compile', '$parse', ($compile, $parse) ->
    link: ($scope, $element, $attrs) ->
        button = $('<button class="coordinate icon-arrow-down"></button>')
        popup = $('<div class="coordinate-popup" ng-include="\'content/views/coordinate.html\'"></div>')
        $element.after(button)
        $element.after(popup)
        button.on 'click', -> popup.toggleClass('open')
        
        child = $scope.$new(true, $scope);
        child.dir = $attrs.coordinate;
        
        $compile(popup)(child)
        
        field = $parse($attrs.ngModel);

        child.values = { }
        
        $scope.$watch $attrs.ngModel, ->                                                        
            current = field($scope)
            if current
                val = parseFloat(current)
                child.values.deg = Math.floor(Math.abs(val))
                child.values.min = Math.floor(Math.abs(val) * 60) % 60
                child.values.sec = (Math.abs(val) * 3600) % 60
                
        calculate = () ->
            if child.values.deg and child.values.min and child.values.sec
                field.assign $scope, (if $attrs.coordinate == "S" then -1 else 1) * (parseFloat(child.values.deg) + (parseFloat(child.values.min) / 60) + (parseFloat(child.values.sec) / 3600))
        child.$watch('values.deg', calculate)
        child.$watch('values.min', calculate)
        child.$watch('values.sec', calculate)
        
        child.close = ->    
            popup.toggleClass('open')
]

angular.module('mipmis').factory 'mapElement', -> $('<div></div>').css('width', '576px').css('height', '400px')
angular.module('mipmis').factory 'mapObject', ['mapElement', (mapElement) -> 
    elm = mapElement;
    new google.maps.Map elm[0], mapTypeId: google.maps.MapTypeId.ROADMAP, zoom: 9
 ]   

angular.module('mipmis').directive 'map', ['$timeout', 'mapElement', 'mapObject', ($timeout, mapElement, mapObject) ->    
    scope: long: '=', lat: '=', centerLat: '@', centerLong: '@'
    link: ($scope, $element, $attrs) ->
        marker = null
        elm = $element
        elm.append mapElement
        center = lat: parseFloat($scope.centerLat), long: parseFloat($scope.centerLong)
        opts = 
            center: new google.maps.LatLng(center.lat, center.long)
            zoom: 9
            mapTypeId: google.maps.MapTypeId.ROADMAP
        
        map = mapObject
        $timeout -> google.maps.event.trigger(map, "resize");
        # set options
        map.panTo opts.center
        
        changing = false
        double = 0
        google.maps.event.addListener map, "dblclick", -> double = true
        
        google.maps.event.addListener map, 'click', (event) ->
            $timeout ->
                if double
                    double = false
                    return

                changing = true
                if marker then marker.setMap null
                marker = new google.maps.Marker
                    position: new google.maps.LatLng event.latLng.lat(), event.latLng.lng()
                    title: "Location"
                    map: map
                
                $scope.lat = event.latLng.lat()
                $scope.long = event.latLng.lng()
                changing = false
            , 100
        if $scope.lat and $scope.long
            pos = new google.maps.LatLng($scope.lat, $scope.long)
            #map.setCenter(pos)
            #if (marker) then marker.setMap(null)
            marker = new google.maps.Marker
                position: pos,
                title: "Fault Location",
                map: map
        $scope.$on '$destroy', -> 
            google.maps.event.clearListeners map, 'click'      
            google.maps.event.clearListeners map, 'dblclick'
            if marker then marker.setMap(null)
            elm.empty()
]
