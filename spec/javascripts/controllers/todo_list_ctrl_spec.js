'use strict'

describe('TodoListCtrl', function() {
  var controller, scope, $httpBackend;
  var todos = [
    {
      "id": 23,
      "title": "Go for a walk",
      "completed": false,
      "archived": false
    },
    {
      "id": 24,
      "title": "Make lunch",
      "completed": false,
      "archived": false
    },
    {
      "id": 25,
      "title": "Write letter",
      "completed": false,
      "archived": false
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
      "archived": false
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

  describe('deleteTodo', function() {
    beforeEach(function() {
      $httpBackend.when('DELETE', '/todos/' + scope.todos[1].id).respond(200, {});
    });

    it('archives the todo', function() {
      scope.deleteTodo(scope.todos[1]);
      $httpBackend.flush()
      expect(scope.todos.length).toEqual(2);
    });
  });

  describe('updateTodo', function() {
    beforeEach(function() {
      $httpBackend.when('POST', '/todos/' + scope.todos[1].id, {
        "id": 24,
        "title": "Make tasty lunch",
        "completed": false,
        "archived": false
      }).respond(200, {});
      scope.editingTodo = scope.todos[1];
      scope.editingTodo.title = 'Make tasty lunch';
    });

    it('updates the todo on blur event', function() {
      scope.updateTodo({ type: 'blur' });
      $httpBackend.flush()
      expect(scope.todos.length).toEqual(3);
    });

    it('updates the todo on return key', function() {
      scope.updateTodo({ keyCode: 13 });
      $httpBackend.flush()
      expect(scope.todos.length).toEqual(3);
    });

    it('does not update the todo on other events', function() {
      scope.updateTodo({});
      expect(scope.todos.length).toEqual(3);
    });
  });

  describe('editTodo', function() {
    it('sets the todo up for editing', function() {
      scope.editTodo(scope.todos[1]);
      expect(scope.editingTodo).toEqual(scope.todos[1]);
      expect(scope.todos.length).toEqual(3);
    });
  });

  describe('classForTodo', function() {
    it('returns the right class for a pending todo', function() {
      expect(scope.classForTodo({ id: 1, title: 'Read a book', completed: false })).toEqual('todo-pending');
    });

    it('returns the right class for a completed todo', function() {
      expect(scope.classForTodo({ id: 1, title: 'Read a book', completed: true })).toEqual('todo-completed');
    });
  });
});
