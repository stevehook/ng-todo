'use strict'

describe('TodoListCtrl', function() {
  var controller, scope, $httpBackend;
  var todos = [
    {
      "id": 23,
      "title": "Go for a walk",
      "completed": false,
      "archived": false,
      "order": 0,
      "created_at": "2014-03-01T21:03:08.825Z",
      "updated_at": "2014-03-16T15:29:00.901Z",
      "complete_by": null
    },
    {
      "id": 24,
      "title": "Make lunch",
      "completed": false,
      "archived": false,
      "order": 0,
      "created_at": "2014-03-01T21:03:08.825Z",
      "updated_at": "2014-03-16T15:29:00.901Z",
      "complete_by": null
    },
    {
      "id": 25,
      "title": "Write letter",
      "completed": false,
      "archived": false,
      "order": 0,
      "created_at": "2014-03-01T21:03:08.825Z",
      "updated_at": "2014-03-16T15:29:00.901Z",
      "complete_by": null
    }
  ];

  beforeEach(function() {
    module('todo');
    inject(function($controller, $rootScope, $injector) {
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.when('GET', /todos/).respond(200, todos);
      scope = $rootScope.$new()
      controller = $controller('TodoListCtrl', { $scope: scope, $route: { current: { params: { } } } })
      $httpBackend.flush()
    });
  });

  it('loads the list of todos from the server', function() {
    expect(scope.todos.length).toEqual(3);
    expect(scope.todos[0].title).toEqual('Go for a walk');
  });

  describe('saveTodo', function() {
    var newTodo = {
      "id": 26,
      "title": "Have a bath",
      "completed": false,
      "archived": false,
      "order": 0,
      "created_at": "2014-03-01T21:03:08.825Z",
      "updated_at": "2014-03-16T15:29:00.901Z",
      "complete_by": null
    };

    beforeEach(function() {
      $httpBackend.when('POST', '/todos').respond(200, newTodo);
    });

    it('saves a new todo', function() {
      scope.newTodo = newTodo;
      scope.saveTodo();
      $httpBackend.flush()
      expect(scope.todos.length).toEqual(4);
      expect(scope.todos[3].title).toEqual('Have a bath');
    });
  });

  describe('completeTodo', function() {
    beforeEach(function() {
      $httpBackend.when('POST', '/todos/' + scope.todos[1].id + '/complete').respond(200, {});
    });

    it('completes the todo', function() {
      scope.completeTodo(scope.todos[1]);
      $httpBackend.flush()
      expect(scope.todos.length).toEqual(3);
      expect(scope.todos[1].completed).toEqual(true);
    });
  });
});
