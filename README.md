- This is a Flatiron course Sinatra project.
It is intended to be a barebones database system for managing deliveries for a group of volunteers.
Database schema consists of 3 tables: Recepients, Volunteers (users), and Deliveries. Recepients and Volunteers are connected via "has many through" relationship, deliveries being the connecting table. Deliveries belong to both volunteers and recepients and both can have "many" deliveries. That setup provides maximum elasticity for the project. You can find detailed PDF of database schema with tables and corresponding fields in "notes" folder.

- Session secret is written in .env file. It will be excluded from github via .gitignore file (it means that you will have to generate your own secret once you download the project. Create .env file and add a line of code that starts with SESSION_SECRET="" Your secret code should be between quotations.)


- Database diagram is included in "notes" folder