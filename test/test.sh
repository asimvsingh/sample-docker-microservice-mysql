#!/bin/bash
#test suite for sample user app
base_url=$1
function http_return_code {
   endpoint=$1
   url=$2
   return_code=$(curl -s -o /dev/null -I -w "%{http_code}" $url:8123/$endpoint)
   echo $return_code
   return $return_code
}

function test_list_users { 
  url=$1 
  http_return_code=$(http_return_code users $url)
  if [ $http_return_code -eq 200 ]; then
  {
     record_count=$(curl -s $url:8123/users | sed 's/,/\n/g' | wc -l)
     ([ $record_count -eq 9 ] && echo "Test Passed: list users") || echo "Test Failed: list users"
  }
  else
  {
    echo " Test Failed: list user ...$url:8123/users endpoint failed with http_response code $http_return_code"
  }
 fi
    
}

function test_search_user {
  url=$1 
  http_return_code=$(http_return_code search?email=homer@thesimpsons.com $url )
  if [ $http_return_code -eq 200 ]; then
  {
     result=$(curl -s $url:8123/search?email=homer@thesimpsons.com | jq .email | sed 's/\"//g')
     ([ $result == "homer@thesimpsons.com" ] && echo "Test Passed: search users") || echo "Test Failed: search users"
  }
  else
  {
    echo " Test Failed: list search user ...$url:8123/search.. endpoint failed with http_response code $http_return_code"
  }
  fi
}

test_list_users $base_url
test_search_user $base_url
