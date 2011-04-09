<<<<<<< HEAD
# The controller that handles administrators.
# At the moment, admins are just treated like regular users who can access
# extra admin stuff, and, as such, are handled by the user controller. The
# admin controller doesn't actually do anything. Why is this here. I mean,
# like, why is this a thing. It isn't used at all.
class AdminController < UserController
=======
class AdminController < UsersController
>>>>>>> d9d7ab9c1a5670d7dfe79a85ef658b2124599e1b
end
