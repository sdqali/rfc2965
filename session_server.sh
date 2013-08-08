#!/usr/bin/env bash
echo "Content-type: text/html"

function login_page {
    echo ""
    cat <<SOMESTRING
<html>
  <body>
    <h1> Hello </h1>
    <form name='login' action='' method='POST'>
      Username: <input type="text" name="user">
      <input type="submit" value="Submit">
    </form>
  </body>
<html>
SOMESTRING
}

function home_page {
    echo $COOKIE_HEADERS
    echo ""
    cat <<SOMESTRING
<html>
  <body>
    <h1> Hello, $USERNAME </h1>
  </body>
<html>
SOMESTRING
}


if [ "$REQUEST_METHOD" = "GET" ]
then
    IFS=":"
    set -- $HTTP_COOKIE
    USERNAME_COOKIE=$1
    IFS=" "
    set -- $USERNAME_COOKIE
    USERNAME=$2
    if [ "$USERNAME" = "" ]
    then
        login_page
    else
        home_page
    fi
elif [ "$REQUEST_METHOD" = "POST" ]
then
    read -n $CONTENT_LENGTH QUERY_STRING_POST
    IFS="="
    set -- $QUERY_STRING_POST
    USERNAME=$2
    COOKIE_HEADERS="Set-Cookie: USERNAME=$USERNAME; expires=Sat, 08-Aug-2015 07:04:50 GMT; path=/; domain=."
    home_page
fi
