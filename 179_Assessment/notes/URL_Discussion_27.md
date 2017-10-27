# URL Discussion

# GET   /lists        -> view all lists
# GET   /lists/new    -> new list form
# POST  /lists        -> create new list

Can use any route you want in a Sinatra application. They are arbitrary, however they should be resource-based. What this means is they should be constructed so that a developer may be able to guess what a route does

For example, to view a list we may do

# GET /lists/1         -> view a single list

It is obvious now that we are fetching list # 1.