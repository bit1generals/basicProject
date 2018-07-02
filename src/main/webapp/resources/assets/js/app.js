(function() {

    'use strict';

    /**
     * Test code for ng-datepicker demo
     */
    angular
        .module('testApp', ['ngFlatDatepicker'])
        .controller('mainController', ['$scope', mainController]);

    function mainController ($scope, min) {

         $scope.minDate = moment.utc(min);
         //$scope.maxDate = moment.utc(max);
    }

})();