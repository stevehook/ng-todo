'use strict'

var todoApp = angular.module('todo', ['ngRoute', 'templates'])
  .run(function($http) { $http.defaults.headers.common.Accept = 'application/json'; })
  .config(function($routeProvider) {
    $routeProvider
      .when('/todos', {
        controller: 'TodoListCtrl',
        templateUrl: 'index.html'
      })
      .when('/todos/archive', {
        controller:'TodoArchiveCtrl',
        templateUrl:'archive.html'
      })
      .otherwise({
        redirectTo:'/todos'
      });
  });

todoApp.controller('TodoArchiveCtrl', function($scope, $http) {
  $scope.todos = [];

  $http.get('/todos/archived').success(function(data) {
    $scope.todos = data;
  });
});

todoApp.controller('TodoListCtrl', function($scope, $http) {
  $scope.newTodo = { title: '', completeBy: Date.now() };
  $scope.todos = [];
  $scope.editingTodo = false;

  $http.get('/todos').success(function(data) {
    $scope.todos = data;
  });

  $scope.saveTodo = function() {
    $http.post('/todos', $scope.newTodo).success(function() {
      $scope.todos.push($scope.newTodo);
      $scope.newTodo = { completeBy: Date.today };
    });
  };

  $scope.completeTodo = function(todo) {
    $http.post('/todos/' + todo.id + '/complete', todo, { headers: { 'X-Http-Method-Override': 'PATCH' } }).
      success(function() {
        todo.completed = true;
      }).
      error(function() {
        console.log('failed');
      });
  };

  $scope.deleteTodo = function(todo) {
    $http.delete('/todos/' + todo.id, todo).
      success(function() {
        $scope.todos.splice($scope.todos.indexOf(todo), 1);
      });
  };

  $scope.updateTodo = function(event) {
    if (event.type == 'blur' || event.keyCode == 13) {
      $http.post('/todos/' + $scope.editingTodo.id, $scope.editingTodo, { headers: { 'X-Http-Method-Override': 'PATCH' } }).
        success(function() {
          $scope.editingTodo = false;
        });
    }
  };

  $scope.editTodo = function(todo) {
    $scope.editingTodo = todo;
  };

  $scope.classForTodo = function(todo) {
    return todo.completed ? 'todo-completed' : 'todo-pending';
  };
});
