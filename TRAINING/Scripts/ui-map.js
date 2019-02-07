﻿/**
 * General-purpose Event binding. Bind any event not natively supported by Angular
 * Pass an object with keynames for events to ui-event
 * Allows $event object and $params object to be passed
 *
 * @example <input ui-event="{ focus : 'counter++', blur : 'someCallback()' }">
 * @example <input ui-event="{ myCustomEvent : 'myEventHandler($event, $params)'}">
 *
 * @param ui-event {string|object literal} The event to bind to as a string or a hash of events with their callbacks
 */
var deferred;

function MapController($scope, $element, $attrs, $q) {
    this.map = $q.defer();
}

angular.module('ui.event', [])
.run(['$rootScope', '$q', '$window', function ($rootScope, $q, $window) {
    deferred = $q.defer();
    $window.onGoogleReady = function () {
        $rootScope.$apply(function() {
            deferred.resolve();
        });
    };
    //     <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&callback=onGoogleReady" defer></script>
    $.getScript('https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&callback=onGoogleReady');
}])
.directive('uiEvent', ['$q', '$parse', 
  function ($q, $parse) {
      return function ($scope, elm, attrs) {
              var events = $scope.$eval(attrs.uiEvent);
          angular.forEach(events, function(uiEvent, eventName) {
              var fn = $parse(uiEvent);
              elm.bind(eventName, function(evt) {
                  var params = Array.prototype.slice.call(arguments);
                  //Take out first paramater (event object);
                  params = params.splice(1);
                  fn($scope, { $event: evt, $params: params });
                  if (!$scope.$$phase) {
                      $scope.$apply();
                  }
              });
          });
      };
  }]);

(function () {
    var app = angular.module('ui.map', ['ui.event']);

    //Setup map events from a google map object to trigger on a given element too,
    //then we just use ui-event to catch events from an element
    function bindMapEvents(scope, eventsStr, googleObject, element) {
        angular.forEach(eventsStr.split(' '), function (eventName) {
            //Prefix all googlemap events with 'map-', so eg 'click' 
            //for the googlemap doesn't interfere with a normal 'click' event
            google.maps.event.addListener(googleObject, eventName, function (event) {
                element.triggerHandler('map-' + eventName, event);
                //We create an $apply if it isn't happening. we need better support for this
                //We don't want to use timeout because tons of these events fire at once,
                //and we only need one $apply
                if (!scope.$$phase) { scope.$apply(); }
            });
        });
    }

    app.factory('maps', function() {
        return {
            api: deferred.promise,
        };
    });

    app.value('uiMapConfig', {}).directive('uiMap',
      ['uiMapConfig', '$parse', '$q', function (uiMapConfig, $parse, $q) {

          var mapEvents = 'bounds_changed center_changed click dblclick drag dragend ' +
            'dragstart heading_changed idle maptypeid_changed mousemove mouseout ' +
            'mouseover projection_changed resize rightclick tilesloaded tilt_changed ' +
            'zoom_changed';
          var options = uiMapConfig || {};

          return {
              restrict: 'A',
              controller: MapController,
              //doesn't work as E for unknown reason
              link: function (scope, elm, attrs, controller) {
                  deferred.promise.then(function() {
                      var center = scope.$eval(attrs.center);
                      var opts = {
                          center: new google.maps.LatLng(center.lat, center.long),
                          zoom: 10,
                          mapTypeId: google.maps.MapTypeId.ROADMAP
                      };
                      var map = new google.maps.Map(elm[0], opts);
                      var model = $parse(attrs.uiMap);

                      //Set scope variable for the map
                      //model.assign(scope, map);

                      controller.map.resolve(map);

                      bindMapEvents(scope, mapEvents, map, elm);
                  });
              }
          };
      }]);

    app.value('uiMapInfoWindowConfig', {}).directive('uiMapInfoWindow',
      ['uiMapInfoWindowConfig', '$parse', '$compile', function (uiMapInfoWindowConfig, $parse, $compile) {

          var infoWindowEvents = 'closeclick content_change domready ' +
            'position_changed zindex_changed';
          var options = uiMapInfoWindowConfig || {};

          return {
              link: function (scope, elm, attrs) {
                  var opts = angular.extend({}, options, scope.$eval(attrs.uiOptions));
                  opts.content = elm[0];
                  var model = $parse(attrs.uiMapInfoWindow);
                  var infoWindow = model(scope);

                  if (!infoWindow) {
                      infoWindow = new google.maps.InfoWindow(opts);
                      model.assign(scope, infoWindow);
                  }

                  bindMapEvents(scope, infoWindowEvents, infoWindow, elm);

                  /* The info window's contents dont' need to be on the dom anymore,
                   google maps has them stored.  So we just replace the infowindow element
                   with an empty div. (we don't just straight remove it from the dom because
                   straight removing things from the dom can mess up angular) */
                  elm.replaceWith('<div></div>');

                  //Decorate infoWindow.open to $compile contents before opening
                  var _open = infoWindow.open;
                  infoWindow.open = function open(a1, a2, a3, a4, a5, a6) {
                      $compile(elm.contents())(scope);
                      _open.call(infoWindow, a1, a2, a3, a4, a5, a6);
                  };
              }
          };
      }]);

    /* 
     * Map overlay directives all work the same. Take map marker for example
     * <ui-map-marker="myMarker"> will $watch 'myMarker' and each time it changes,
     * it will hook up myMarker's events to the directive dom element.  Then
     * ui-event will be able to catch all of myMarker's events. Super simple.
     */
    function mapOverlayDirective(directiveName, events) {
        app.directive(directiveName, [function () {
            return {
                restrict: 'A',
                require: '^uiMap',
                link: function (scope, elm, attrs, controller) {
                    controller.map.promise.then(function (map) {
                        var position = scope.$eval(attrs.position);
                        var marker = new google.maps.Marker({
                            map: map,
                            position: new google.maps.LatLng(parseFloat(position.lat), parseFloat(position.long))
                        });
                        //bindMapEvents(scope, events, marker, elm);
                    });
                }
            };
        }]);
    }

    mapOverlayDirective('uiMapMarker',
      'animation_changed click clickable_changed cursor_changed ' +
        'dblclick drag dragend draggable_changed dragstart flat_changed icon_changed ' +
        'mousedown mouseout mouseover mouseup position_changed rightclick ' +
        'shadow_changed shape_changed title_changed visible_changed zindex_changed');

    mapOverlayDirective('uiMapPolyline',
      'click dblclick mousedown mousemove mouseout mouseover mouseup rightclick');

    mapOverlayDirective('uiMapPolygon',
      'click dblclick mousedown mousemove mouseout mouseover mouseup rightclick');

    mapOverlayDirective('uiMapRectangle',
      'bounds_changed click dblclick mousedown mousemove mouseout mouseover ' +
        'mouseup rightclick');

    mapOverlayDirective('uiMapCircle',
      'center_changed click dblclick mousedown mousemove ' +
        'mouseout mouseover mouseup radius_changed rightclick');

    mapOverlayDirective('uiMapGroundOverlay',
      'click dblclick');

})();