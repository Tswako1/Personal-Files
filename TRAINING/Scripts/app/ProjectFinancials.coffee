@ProjectFinancialsController = ['$scope','$http', 'projectFinancials','notification', 'breadcrumb', ($scope, $http,  projectFinancials, notification, breadcrumb) ->

    $scope.saveProjectFinancials =  ->
        if $scope.projectFinancialsForm.$valid 
            $http.post 'api/projectFinancials',  projectId: projectFinancials.data[0].id, projectBudgets: records, projectActuals: actuals
            notification("Successfully saved")

    $scope.projectFinancials = projectFinancials.data
    $scope.sources = projectFinancials.data[0].fundingSources
 
    dateRange = (from,to) -> 
        start = new Date(from)
        end = new Date(to)
        range = []
        while start <= end
            range.push(year: start.getFullYear(),month: start.getMonth()+1)
            start.setMonth(start.getMonth()+1)
        range

    range = dateRange(projectFinancials.data[0].startDate,projectFinancials.data[0].endDate)
    records = $scope.sources.flatMap (source)->
        range.map (period)->
            financialYearPeriod = finYearPeriod(period.year,period.month)
            item = projectFinancials.data[0].projectBudgets.first (x)-> x.financialYear == financialYearPeriod.finYear && x.financialPeriod == financialYearPeriod.finPeriod && x.fundingSourceId == source.id
            if item
                item.fundingSource = null
                item 
            else 
                financialYear:  financialYearPeriod.finYear, financialPeriod: financialYearPeriod.finPeriod, fundingSourceId: source.id , amount: 0
    actuals = range.map (period)->
        financialYearPeriod = finYearPeriod(period.year,period.month)
        item = projectFinancials.data[0].projectActuals.first (x)-> x.financialYear == financialYearPeriod.finYear && x.financialPeriod == financialYearPeriod.finPeriod 
        if item
            item 
        else 
            financialYear:  financialYearPeriod.finYear, financialPeriod: financialYearPeriod.finPeriod, amount: 0
    
    $scope.getActual = (year, period) ->
       fst = actuals.first((x) -> x.financialYear == parseInt(year) && x.financialPeriod == parseInt(period))              

    $scope.isInFuture = (date) ->
        now = new Date()
        dt = if date.financialPeriod < 7 then new Date(date.financialYear - 1, date.financialPeriod + 5, 1) else new Date(date.financialYear, date.financialPeriod - 6, 1)
        dt.setMonth(dt.getMonth() + 1)        
        dt >= now 
    
    $scope.calculatePeriodTotals = (sources) ->
        this.$watch 'month.value', (value) ->
            sources.total.amount = sources.reduce(((xs,x) -> parseFloat(x.amount) + xs),0) 
        , true
        sources.total = amount: 0

    $scope.calculateAnnualTotals = (year, source) ->
        this.$watch 'year.value', (value) ->
            year.total[source.id].amount = year.value.flatMap((x)->x.value)
                                                     .filter((x)->x.fundingSourceId == source.id)
                                                     .reduce(((xs,x) -> parseFloat(x.amount) + xs),0)
        , true
        year.total = year.total || {}
        year.total[source.id] = amount: 0
        
    $scope.calculateTotalTotals = (year) ->
        this.$watch 'year.value', (value) -> 
           year.budgetTotal.amount = year.value.flatMap((x)->x.value).reduce(((xs,x) -> parseFloat(x.amount) + xs),0)
        , true
        year.budgetTotal = amount: 0
    
    $scope.calculateActualTotals = (year) ->
        $scope.$watch 'actuals', (actuals) ->
             year.actualsTotal.amount = actuals.filter((x)->x.financialYear == parseInt(year.key)).reduce(((xs,x) -> parseFloat(x.amount) + xs),0)
        , true
        year.actualsTotal = amount: 0

    $scope.actuals = actuals

    years = []
    for month in records.groupBy((x)->x.financialYear)
        years.push key: month.key, value: month.value.groupBy((x)->x.financialPeriod)
    $scope.financials = years
    $scope.count = count 
    $scope.expandedYear = finYearPeriod(new Date().getFullYear(),new Date().getMonth()+1).finYear
    
    breadcrumb [
        {description: projectFinancials.data[0].name, url: "/projectRegistration/#{projectFinancials.data[0].id}"},
        {description: 'Financials'}
    ]
]
