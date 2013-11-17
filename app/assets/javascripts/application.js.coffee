#= require jquery
#= require twitter/bootstrap/bootstrap-modal
#= require twitter/bootstrap/bootstrap-alert




SalesTaxCtrl = ($scope) ->


    # Items that will be loaded in the view
    $scope.items= [ ]
    # Dynamic models to mute the imported text for each model
    $scope.muted= {}

    # Toggle class for ajax call activity
    $scope.loading= "hide"


    # Add an empty item and use a timestamp as id
    $scope.addItem= ->
        @submitted = false
        @items.push id: $.now()

     # Empty array to reset the form
    $scope.reset= ->
        @submitted = false
        @items= [ { id: $.now()} ]

    # Remove single item from the array of items
    $scope.remove = (index) ->
        @items.splice(index, 1)
        $scope.reset() if @items.length==0

    # Calculate the sales tax via a call to rails server and loading the resulting json as a view to the modal.
    $scope.compute = (form)->
        if form.$valid
            ele= $("#compute")
            $scope.loading= ""
            $.post ele[0].action,ele.serialize(),(data)->
                $scope.receipt= data
                $scope.loading= "hide"
                $scope.$apply()
                $('#receipt').modal('show')

    # Initilize with the reset stage of the form
    $scope.reset()



# Register the app
angular
.module("salesTaxApp", [])
.controller("SalesTaxCtrl", ['$scope',SalesTaxCtrl])