Configuration Apache
===


# add user


Generate password
```
   htpasswd -nb canard canard
   htpasswd -nb oie oie
 ```
First I created a database file and inserted some user information
   for test using sqlite3.
```
   sqlite3 userpasswd.db
   sqlite3> create table authn (user_name char(20) not null primary key, user_passwd char(20) not null);
   # sqlite3> insert into authn values ('user', 'passwd'); # encrypted
   
   sqlite3> insert into authn values ('oie', '$apr1$WHNyuDi7$KPNv5GrosE4JDAf4mI9Fc/'); # oie:oie
   sqlite3> insert into authn values ('canard', '$apr1$DW6xnZ/J$Q5tDqjfKwhLaus7YXte1/1'); # canard:canard
   sqlite3> insert into authn values ('test', '$apr1$0/aHpaid$yYJ2BoSS7U1CvZmX2S3nN0'); # test:test
```

2. Then add the following configuration to httpd.conf. It's almost the
   same with the sample in the document except the arguments for DBDriver
   and DBDParams. The required modules are all loaded.
```
# For authent
DBDriver sqlite3
DBDParams "/userpasswd.db"
DBDMin  4
DBDKeep 8
DBDMax  20
DBDExptime 300

#
# DocumentRoot: The directory out of which you will serve your
# documents. By default, all requests are taken from this directory, but
# symbolic links and aliases may be used to point to other locations.
#
DocumentRoot "/usr/local/apache2/htdocs"
<Directory "/usr/local/apache2/htdocs">
    Options Indexes FollowSymLinks
    AuthType Basic
    AuthName "Cached Authentication Example"
    AuthBasicProvider socache dbd
    AuthDBDUserPWQuery "SELECT user_passwd FROM authn WHERE user_name=%s"
    AuthnCacheProvideFor dbd
    Require valid-user
    #Optionnel
    AuthnCacheContext dbd-authn-example
</Directory>
```