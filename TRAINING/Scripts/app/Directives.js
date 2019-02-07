(function() {
  var documentManagementController;

  angular.module('mipmis').directive("date", [
    'dateFilter', '$parse', '$timeout', function(dateFilter, $parse, $timeout) {
      return {
        restrict: "CA",
        priority: -1,
        link: function(scope, element, attributes) {
          var unwatch;
          unwatch = scope.$watch(attributes.ngModel, function(value) {
            return $parse(attributes.ngModel).assign(scope, dateFilter(value, 'yyyy/MM/dd'));
          });
          return element.datepicker({
            format: "yyyy/mm/dd",
            autoclose: true
          }).on("changeDate", function(e) {
            return scope.$apply(function() {
              $parse(attributes.ngModel).assign(scope, dateFilter(e.date, 'yyyy/MM/dd'));
              element.focus();
              return element.datepicker("hide");
            });
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive('mycurr', [
    '$filter', '$parse', function($filter, $parse) {
      return {
        require: 'ngModel',
        restrict: 'A',
        link: function(scope, element, attrs, ngModel) {
          var parse;
          parse = function(viewValue, noRender) {
            var clean, dotSplit;
            if (!viewValue) {
              return viewValue;
            }
            clean = viewValue.toString().replace(/[^0-9.]+/g, '').replace(/\.{2,}/, '.');
            dotSplit = clean.split('.');
            if (dotSplit.length > 2) {
              clean = dotSplit[0] + '.' + dotSplit[1].slice(0, 2);
            } else if (dotSplit.length === 2) {
              clean = dotSplit[0] + '.' + dotSplit[1].slice(0, 2);
            }
            if (!noRender) {
              ngModel.$render();
            }
            return clean;
          };
          ngModel.$parsers.unshift(parse);
          ngModel.$render = function() {
            var clean, currencyValue, dotSplit;
            console.log('viewValue', ngModel.$viewValue);
            console.log('modelValue', ngModel.$modelValue);
            clean = parse(ngModel.$viewValue, true);
            if (!clean) {
              element.val(clean);
              return;
            }
            currencyValue = void 0;
            dotSplit = clean.split('.');
            if (clean[clean.length - 1] === '.') {
              currencyValue = $filter('number')(parseFloat(clean)) + '.';
            } else if (clean.indexOf('.') !== -1 && dotSplit[dotSplit.length - 1].length === 1) {
              currencyValue = $filter('number')(parseFloat(clean), 1);
            } else if (clean.indexOf('.') !== -1 && dotSplit[dotSplit.length - 1].length === 1) {
              currencyValue = $filter('number')(parseFloat(clean), 2);
            } else {
              currencyValue = $filter('number')(parseFloat(clean));
            }
            element.val(currencyValue);
          };
        }
      };
    }
  ]);

  angular.module('mipmis').directive('toggle', [
    function() {
      return {
        restrict: 'A',
        template: '<button ng-click="toggle = !toggle"></button>',
        replace: true,
        scope: {
          toggle: '='
        }
      };
    }
  ]);

  angular.module('mipmis').directive("ngModel", [
    '$rootScope', function($rootScope) {
      return {
        restrict: "A",
        link: function(scope, element, attributes) {
          var messages;
          messages = {
            currency: "This field requires a valid currency amount. Please enter an amount in one of the following formats: 123456.78, 123 456.67",
            numeric: "This field requires a valid number.",
            date: "This field requires a valid date.",
            percentage: "This field requires a valid percentage."
          };
          element.after($("<div class='error'></div>").attr("validation-message", attributes.validationmessage || messages[attributes.fieldtype] || "This field does not have a valid value."));
          element.blur(function() {
            return element.addClass('blurred');
          });
          return element.focus(function() {
            return $rootScope.$broadcast("focus", element);
          });
        }
      };
    }
  ]);

  documentManagementController = [
    '$scope', '$document', 'documentType', 'foreignId', 'foreignType', 'documents', '$http', 'parentScope', 'documentTypes', 'title', 'close', function($scope, $document, documentType, foreignId, foreignType, documents, $http, parentScope, documentTypes, title, close) {
      var adding, queue;
      queue = null;
      adding = false;
      $scope.close = close;
      $scope.documentType = documentType;
      $scope.foreignId = foreignId;
      $scope.foreignType = foreignType;
      $scope.options = {
        url: 'upload/fileHandler'
      };
      $scope.documents = documents.data;
      $scope.adddocument = function($event) {
        $event.stopPropagation();
        return $('#add-file').click();
      };
      $document.on('click', function(event) {
        if (event.target === $('.modal.fade.in')[0]) {
          $document.off('click');
          return close.value.close();
        }
      });
      $scope.setqueue = function(myQueue) {
        return queue = myQueue;
      };
      $scope.increment = function() {
        return parentScope.numberOfDocuments = documents.data.length + queue.length;
      };
      $scope.now = Date.now();
      $scope.deletedocument = function(document) {
        return $http["delete"]("api/document/" + document.id).then(function() {
          documents.data.splice(documents.data.indexOf(document), 1);
          return parentScope.numberOfDocuments--;
        });
      };
      return $scope.documentTypeName = title || documentTypes.data.filter(function(x) {
        return x.id === documentType;
      })[0].description;
    }
  ];

  angular.module('mipmis').directive("documentManagement", [
    '$rootScope', function($rootScope) {
      return {
        controller: [
          '$scope', '$modal', '$element', function($scope, $modal, $element) {
            return $scope.open = function(documentType, foreignId, foreignType, title) {
              var close;
              close = {};
              return close.value = $modal.open({
                templateUrl: "content/views/documentUpload.html",
                controller: documentManagementController,
                resolve: {
                  documents: [
                    '$http', function($http) {
                      return $http.get("api/document/?documentType=" + documentType + "&foreignId=" + foreignId + "&foreignType=" + foreignType);
                    }
                  ],
                  documentType: function() {
                    return documentType;
                  },
                  foreignId: function() {
                    return foreignId;
                  },
                  foreignType: function() {
                    return foreignType;
                  },
                  parentScope: function() {
                    return $scope;
                  },
                  documentTypes: [
                    '$http', function($http) {
                      return $http.get("lookup/DocumentTypes");
                    }
                  ],
                  title: function() {
                    return title;
                  },
                  close: function() {
                    return close;
                  }
                }
              });
            };
          }
        ],
        restrict: "C",
        link: function(scope, element, attributes) {
          var f;
          return f = 1;
        },
        template: "<span class='project-documents' ng-click='open(documentType(),foreignId(),foreignType(),documentTitle)'>                <a  href=''><i class='icon-cabinet'></i>                <span ng-hide='numberOfDocuments==0' class='badge'>{{numberOfDocuments}}</span>                </a>                </span>",
        replace: true,
        scope: {
          numberOfDocuments: "=documentCount",
          foreignId: "&foreignId",
          foreignType: "&foreignType",
          documentType: "&documentType",
          documentTitle: "@"
        }
      };
    }
  ]);

  angular.module('mipmis').directive("select2", [
    '$timeout', function($timeout) {
      return {
        restrict: "A",
        link: function(scope, element, attributes) {
          return scope.$watch(attributes.data, function(value) {
            if (value) {
              return $timeout(function() {
                return element.select2();
              });
            }
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive("form", function() {
    return {
      restrict: "E",
      link: function(scope, element, attributes) {
        return element.bind("submit", function() {
          return element.addClass('submitted');
        });
      }
    };
  });

  angular.module('mipmis').directive("lookup", [
    '$http', function($http) {
      return {
        restrict: "A",
        scope: {
          id: "=id"
        },
        link: function(scope, element, attributes) {
          return $http.get('lookup/' + attributes.lookup).then(function(response) {
            var values;
            values = response.data.filter(function(x) {
              return x.id === scope.id;
            });
            if (values.length > 0) {
              return element.text(values[0].description);
            }
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive("yesno", [
    '$http', function($http) {
      return {
        restrict: "A",
        link: function(scope, element, attributes) {
          var value;
          if (attributes.yesno === "true") {
            value = "Yes";
          } else {
            value = "No";
          }
          return element.text(value);
        }
      };
    }
  ]);

  angular.module('mipmis').directive("condition", [
    '$http', function($http) {
      return {
        restrict: "A",
        link: function(scope, element, attributes) {
          if (attributes.condition === "1") {
            return element.addClass('One');
          } else if (attributes.condition === "2") {
            return element.addClass('Two');
          } else if (attributes.condition === "3") {
            return element.addClass('Three');
          } else if (attributes.condition === "4") {
            return element.addClass('Four');
          } else if (attributes.condition === "5") {
            return element.addClass('Five');
          }
        }
      };
    }
  ]);

  angular.module('mipmis').filter('periodNumberAsText', function() {
    var months;
    months = {
      1: 'Jul',
      2: 'Aug',
      3: 'Sep',
      4: 'Oct',
      5: 'Nov',
      6: 'Dec',
      7: 'Jan',
      8: 'Feb',
      9: 'Mar',
      10: 'Apr',
      11: 'May',
      12: 'Jun'
    };
    return function(x) {
      return months[x];
    };
  });

  angular.module('mipmis').filter('financialYear', function() {
    return function(x) {
      return parseInt(x) - 1 + '/' + x.substring(2);
    };
  });

  angular.module('mipmis').factory('breadcrumb', [
    '$rootScope', '$route', '$location', function($rootScope, $route, $location) {
      return function(crumbs) {
        var x;
        return $rootScope.breadcrumbs = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = crumbs.length; _i < _len; _i++) {
            x = crumbs[_i];
            _results.push({
              description: x.description,
              url: x.url || $location.$$url
            });
          }
          return _results;
        })();
      };
    }
  ]);

  angular.module('mipmis').directive('placeholder', [
    '$rootScope', function($rootScope) {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          $rootScope.$on("$routeChangeStart", function(event) {
            return element.html('');
          });
          return $rootScope.$on("placeholder:" + attrs.placeholder, function(event, content) {
            element.html('');
            return element.append(content);
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive('placeholderContent', [
    function() {
      return {
        restrict: 'A',
        transclude: true,
        compile: function(element, attrs, transclude) {
          return function(scope) {
            return transclude(scope, function(clone) {
              return scope.$emit("placeholder:" + attrs.placeholderContent, clone);
            });
          };
        }
      };
    }
  ]);

  angular.module('mipmis').directive('chart', [
    '$http', function($http) {
      return {
        restrict: 'A',
        template: '<div><svg height="300px"></svg></div>',
        scope: {
          values: '='
        },
        link: function(scope, element, attrs) {
          var actualDate, actualValues, actuals, budgetValues, budgets, chart, data, xs;
          actualDate = function(year, period) {
            if (period < 7) {
              return new Date(year, period + 6, 1);
            } else {
              return new Date(year + 1, period - 6, 1);
            }
          };
          xs = scope.values.projectBudgets.groupBy(function(x) {
            return actualDate(x.financialYear, x.financialPeriod).toISOString();
          });
          actualValues = scope.values.projectActuals.reduce(function(a, b, i) {
            return a.concat({
              x: actualDate(b.financialYear, b.financialPeriod),
              y: b.amount + a[a.length - 1].y
            });
          }, [
            {
              x: 0,
              y: 0
            }
          ]);
          budgetValues = xs.reduce(function(a, b, i) {
            return a.concat({
              x: new Date(b.key),
              y: b.value.reduce((function(y1, y2) {
                return y1 + y2.amount;
              }), 0) + a[a.length - 1].y
            });
          }, [
            {
              x: 0,
              y: 0
            }
          ]);
          actuals = {
            key: 'Actuals',
            values: actualValues.slice(1)
          };
          budgets = {
            key: 'Budgets',
            color: "red",
            values: budgetValues.slice(1)
          };
          data = [actuals, budgets];
          return chart = nv.addGraph(function() {
            var el;
            el = element.find('svg')[0];
            chart = nv.models.lineChart();
            chart.xAxis.axisLabel('Period').tickFormat(function(d) {
              return d3.time.format('%Y/%m')(new Date(d));
            });
            chart.yAxis.axisLabel('Amount (R)').tickFormat(d3.format('R d'));
            d3.select(el).datum(data).transition().duration(500).call(chart);
            return chart;
          });
        }
      };
    }
  ]);

  angular.module('mipmis').factory('operation', [
    function() {
      var operations;
      operations = {};
      access.map(function(x) {
        return operations[x] = true;
      });
      return function(x) {
        return operations[x];
      };
    }
  ]);

  angular.module('mipmis').directive('operation', [
    function() {
      var operations;
      operations = {};
      access.map(function(x) {
        return operations[x] = true;
      });
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          if (!operations[attrs.operation]) {
            return element.remove();
          }
        }
      };
    }
  ]);

  angular.module('mipmis').directive('bulletChart', [
    function() {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          var markers, measures;
          measures = scope.$eval(attrs.measures);
          markers = scope.$eval(attrs.markers);
          return nv.addGraph(function() {
            var chart;
            chart = nv.models.bulletChart();
            return d3.select(element[0]).datum({
              title: scope.$eval(attrs.description),
              ranges: [0, Math.max(measures, markers) * 1.1],
              measures: [measures],
              markers: [markers]
            }).transition().duration(1000).call(chart);
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive("mipmisAccordion", [
    function() {
      return {
        restrict: "A",
        controller: [
          '$scope', function($scope) {
            var current, sections;
            sections = $scope.sections = [];
            current = null;
            this.add = function(section) {
              if (sections.length === 0) {
                section.expanded = true;
                current = section;
              }
              return sections.push(section);
            };
            return this.expand = function(section) {
              section.expanded = true;
              current.expanded = false;
              return current = section;
            };
          }
        ],
        link: function(scope, element, attributes) {}
      };
    }
  ]);

  angular.module('mipmis').directive("accordionSection", [
    function() {
      return {
        restrict: "A",
        require: '^mipmisAccordion',
        transclude: true,
        replace: true,
        template: '<li ng-class="{expanded: expanded}"><h4 ng-click="expand()"><a href="{{href}}">{{description}}</a></h4><div ng-transclude></div></li>',
        scope: {
          description: '@accordionSection',
          href: '@'
        },
        link: function(scope, element, attributes, accordion) {
          accordion.add(scope);
          return scope.expand = function() {
            return accordion.expand(scope);
          };
        }
      };
    }
  ]);

  angular.module('mipmis').directive('calendar', [
    '$compile', function($compile) {
      return {
        restrict: 'A',
        replace: true,
        link: function(scope, elm, attrs) {
          var month, render, today, year;
          today = new Date();
          year = today.getFullYear();
          month = today.getMonth();
          render = function(year, month) {
            var days, header, months, nextMonth, nextYear, prevMonth, prevYear, start, stop, table;
            elm.html('');
            months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            start = new Date(year, month, 1);
            stop = d3.time.month.offset(start, 1);
            if (start.getDay() !== 1) {
              start = d3.time.day.utc.offset(start, -1 * ((start.getDay() === 0 ? 7 : start.getDay()) - 1));
            }
            days = d3.time.day.utc.range(start, stop);
            nextYear = function() {
              if (month < 11) {
                return year;
              } else {
                return year + 1;
              }
            };
            nextMonth = function() {
              if (month < 11) {
                return month + 1;
              } else {
                return 0;
              }
            };
            prevYear = function() {
              if (month > 0) {
                return year;
              } else {
                return year - 1;
              }
            };
            prevMonth = function() {
              if (month > 0) {
                return month - 1;
              } else {
                return 11;
              }
            };
            table = d3.select(elm[0]).append('table').attr('class', 'month');
            header = table.append('thead').append('tr');
            header.append('th').attr('class', 'back').append('button').on('click', function() {
              return scope.$eval(attrs.monthChange)(prevYear(), prevMonth(), function() {
                return render(prevYear(), prevMonth());
              });
            });
            header.append('th').attr('colspan', '5').text(months[month] + ' ' + year);
            header.append('th').attr('class', 'forward').append('button').on('click', function() {
              return scope.$eval(attrs.monthChange)(nextYear(), nextMonth(), function() {
                return render(nextYear(), nextMonth());
              });
            });
            table.append('tbody').selectAll('tr').data(days.filter(function(x) {
              return x.getDay() === 1;
            })).enter().append('tr').selectAll('td').data(function(d) {
              return d3.time.day.utc.range(d, d3.time.day.offset(d, 7));
            }).enter().append('td').on('click', function(d) {
              return scope.$apply(function() {
                return scope.$eval(attrs.select)(d);
              });
            }).attr('pop', function(d) {
              return d;
            }).attr('class', function(d) {
              if (d.getMonth() === month) {
                return scope.$eval(attrs.callback)(d);
              } else {
                return "";
              }
            }).text(function(d) {
              if (d.getMonth() === month) {
                return d.getDate();
              } else {
                return "";
              }
            });
            return $compile(table[0])(scope);
          };
          return attrs.$observe('callback', function() {
            return render(year, month);
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive('node', [
    function() {
      var loading;
      loading = true;
      return {
        restrict: 'A',
        transclude: true,
        replace: true,
        scope: {
          value: '@',
          label: '@',
          organisations: '='
        },
        required: 'node',
        controller: [
          '$scope', '$element', '$timeout', function($scope, $element, $timeout) {
            var busy, children;
            children = [];
            $scope.state = 'none';
            if ($scope.value && $scope.organisations && $scope.organisations.indexOf($scope.value) >= 0) {
              $scope.state = 'all';
            } else {
              $scope.state = 'none';
            }
            this.add = function(child) {
              $scope.hasChildren = true;
              children.push(child);
              return child.$watch('state', function(val) {
                var allSelectedChildren, noSelectedChildren;
                if (busy) {
                  return;
                }
                noSelectedChildren = children.filter(function(x) {
                  return x.state === 'none';
                }).length;
                allSelectedChildren = children.filter(function(x) {
                  return x.state === 'all';
                }).length;
                if (noSelectedChildren === children.length) {
                  if (loading) {
                    $scope.collapsed = true;
                  }
                  return $scope.state = 'none';
                } else if (allSelectedChildren === children.length) {
                  if (loading) {
                    $scope.collapsed = false;
                  }
                  return $scope.state = 'all';
                } else {
                  if (loading) {
                    $scope.collapsed = false;
                  }
                  return $scope.state = 'some';
                }
              });
            };
            busy = false;
            $scope.setStatus = function(newState) {
              var child, _i, _len;
              busy = true;
              $scope.state = newState;
              for (_i = 0, _len = children.length; _i < _len; _i++) {
                child = children[_i];
                child.setStatus($scope.state);
              }
              if ($scope.value && newState === 'all' && $scope.organisations.indexOf($scope.value) < 0) {
                $scope.organisations.push($scope.value);
              }
              if ($scope.value && newState === 'none' && $scope.organisations.indexOf($scope.value) >= 0) {
                $scope.organisations.splice($scope.organisations.indexOf($scope.value), 1);
              }
              return busy = false;
            };
            return $scope.click = function() {
              loading = false;
              if ($scope.state === 'none') {
                return $scope.setStatus('all');
              } else if ($scope.state === 'all') {
                return $scope.setStatus('none');
              } else if ($scope.state === 'some') {
                return $scope.setStatus('all');
              }
            };
          }
        ],
        template: '<li ng-class="{leaf: !hasChildren, collapsed: collapsed}"><button class="expanded" toggle="collapsed"></button><button class="state" ng-class="state" ng-click="click()"></button><div ng-transclude></div></li>',
        link: function(scope, element, attrs, node) {
          var parent;
          parent = element.parent().controller('node');
          if (parent) {
            return parent.add(scope);
          }
        }
      };
    }
  ]);

  angular.module('mipmis').directive('popup', [
    '$document', '$rootScope', 'localStorageService', function($document, $rootScope, localStorageService) {
      return {
        transclude: true,
        template: '<div>\
                    <a href="" class="glyphicon glyphicon-user user-menu" ng-click="toggle($event)"/>\
                </div>\
                <div class="user-options" ng-show="isOpen" ng-click="$event.stopPropagation()">\
                    <div class="triangle"></div>\
                    <div ng-transclude></div>\
                    <div style="position: absolute; bottom: 10px; left: 10px" ng-hide="change">\
                        <button class="btn btn-default" ng-click="dismiss()">Dismiss</button>\
                    </div>\
                 </div>',
        scope: {
          change: '='
        },
        link: function($scope, $element, $attrs) {
          $scope.isOpen = !localStorageService.get('welcome.dismissed');
          $scope.dismiss = function() {
            $scope.isOpen = false;
            return localStorageService.add('welcome.dismissed', true);
          };
          $scope.toggle = function($event) {
            $event.stopPropagation();
            return $scope.isOpen = !$scope.isOpen;
          };
          return $document.on('click', function(event) {
            if ($scope.isOpen && !$rootScope.$$phase) {
              return $scope.$apply(function() {
                return $scope.isOpen = false;
              });
            }
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive('fieldinfo', [
    '$document', '$rootScope', 'localStorageService', function($document, $rootScope, localStorageService) {
      return {
        template: '<div class="glyphicon glyphicon-info-sign user-menu" ng-click="toggle($event)"><div ng-include="\'content/information/\' + file + \'.htm\'" ng-show="isOpen"></div></div>',
        scope: true,
        link: function($scope, $element, $attrs) {
          $scope.file = $attrs.fieldinfo;
          $scope.isOpen = !localStorageService.get('welcome.dismissed');
          $scope.dismiss = function() {
            $scope.isOpen = false;
            return localStorageService.add('welcome.dismissed', true);
          };
          $scope.toggle = function($event) {
            $event.stopPropagation();
            return $scope.isOpen = !$scope.isOpen;
          };
          return $document.on('click', function(event) {
            if ($scope.isOpen && !$rootScope.$$phase) {
              return $scope.$apply(function() {
                return $scope.isOpen = false;
              });
            }
          });
        }
      };
    }
  ]);

  angular.module('mipmis').directive('coordinate', [
    '$compile', '$parse', function($compile, $parse) {
      return {
        link: function($scope, $element, $attrs) {
          var button, calculate, child, field, popup;
          button = $('<button class="coordinate icon-arrow-down"></button>');
          popup = $('<div class="coordinate-popup" ng-include="\'content/views/coordinate.html\'"></div>');
          $element.after(button);
          $element.after(popup);
          button.on('click', function() {
            return popup.toggleClass('open');
          });
          child = $scope.$new(true, $scope);
          child.dir = $attrs.coordinate;
          $compile(popup)(child);
          field = $parse($attrs.ngModel);
          child.values = {};
          $scope.$watch($attrs.ngModel, function() {
            var current, val;
            current = field($scope);
            if (current) {
              val = parseFloat(current);
              child.values.deg = Math.floor(Math.abs(val));
              child.values.min = Math.floor(Math.abs(val) * 60) % 60;
              return child.values.sec = (Math.abs(val) * 3600) % 60;
            }
          });
          calculate = function() {
            if (child.values.deg && child.values.min && child.values.sec) {
              return field.assign($scope, ($attrs.coordinate === "S" ? -1 : 1) * (parseFloat(child.values.deg) + (parseFloat(child.values.min) / 60) + (parseFloat(child.values.sec) / 3600)));
            }
          };
          child.$watch('values.deg', calculate);
          child.$watch('values.min', calculate);
          child.$watch('values.sec', calculate);
          return child.close = function() {
            return popup.toggleClass('open');
          };
        }
      };
    }
  ]);

  angular.module('mipmis').factory('mapElement', function() {
    return $('<div></div>').css('width', '576px').css('height', '400px');
  });

  angular.module('mipmis').factory('mapObject', [
    'mapElement', function(mapElement) {
      var elm;
      elm = mapElement;
      return new google.maps.Map(elm[0], {
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoom: 9
      });
    }
  ]);

  angular.module('mipmis').directive('map', [
    '$timeout', 'mapElement', 'mapObject', function($timeout, mapElement, mapObject) {
      return {
        scope: {
          long: '=',
          lat: '=',
          centerLat: '@',
          centerLong: '@'
        },
        link: function($scope, $element, $attrs) {
          var center, changing, double, elm, map, marker, opts, pos;
          marker = null;
          elm = $element;
          elm.append(mapElement);
          center = {
            lat: parseFloat($scope.centerLat),
            long: parseFloat($scope.centerLong)
          };
          opts = {
            center: new google.maps.LatLng(center.lat, center.long),
            zoom: 9,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          map = mapObject;
          $timeout(function() {
            return google.maps.event.trigger(map, "resize");
          });
          map.panTo(opts.center);
          changing = false;
          double = 0;
          google.maps.event.addListener(map, "dblclick", function() {
            return double = true;
          });
          google.maps.event.addListener(map, 'click', function(event) {
            return $timeout(function() {
              if (double) {
                double = false;
                return;
              }
              changing = true;
              if (marker) {
                marker.setMap(null);
              }
              marker = new google.maps.Marker({
                position: new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()),
                title: "Location",
                map: map
              });
              $scope.lat = event.latLng.lat();
              $scope.long = event.latLng.lng();
              return changing = false;
            }, 100);
          });
          if ($scope.lat && $scope.long) {
            pos = new google.maps.LatLng($scope.lat, $scope.long);
            marker = new google.maps.Marker({
              position: pos,
              title: "Fault Location",
              map: map
            });
          }
          return $scope.$on('$destroy', function() {
            google.maps.event.clearListeners(map, 'click');
            google.maps.event.clearListeners(map, 'dblclick');
            if (marker) {
              marker.setMap(null);
            }
            return elm.empty();
          });
        }
      };
    }
  ]);

}).call(this);
