# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - ApplicationController inherits form Sinatra::Base
- [x] Use ActiveRecord for storing information in a database - Models inherit from ActiveRecord::Base
- [x] Include more than one model class (e.g. User, Post, Category) - User, Restaurant, MenuItem, Review
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - User has many reviews, Restaurant has many menu_items, etc.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Review belongs to user, etc.
- [x] Include user accounts with unique login attribute (username or email) - bcrypt authentication utilized, model validates for unique user.slug
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Reviews can be created, read, updated, and destroyed
- [x] Ensure that users can't modify content created by other users - routes and views check object creator against active user
- [x] Include user input validations - User must have name, Review must have rating
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - general error dislayed when objects fail to create or update
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits - yes
- [x] Your commit messages are meaningful - mostly
- [x] You made the changes in a commit that relate to the commit message - yes
- [x] You don't include changes in a commit that aren't related to the commit message - Easier to meet this standard at beginning and end of project when commits are more concrete or smaller. I struggled in the middle when rapidly working through code and interwoven bug fixes.

