# use the bash interpreter to execute the file
#!/bin/bash

PHONEBOOK_ENTRIES="bash_phonebook_entries"

declare -A options=( 
  ["new <name> <number>"]="add entry" 
  ["list"]="display entries" 
  ["lookup <name>"]="display number(s) associated with given name" 
  ["remove <name>"]="delete all entries associated with given name" 
  ["clear"]="delete entire phonebook" 
)

if [ "$#" -lt 1 ]; then
  exit 1

elif [ "$1" = "new" ]; then
  # add entry to phonebook
  # format: firstname lastname number
  echo "$2 $3 $4" >> $PHONEBOOK_ENTRIES

elif [ "$1" = "list" ]; then
  if [ ! -e $PHONEBOOK_ENTRIES ] || [ ! -s $PHONEBOOK_ENTRIES ]; then
    echo "phonebook is empty"
  else
    # display every entry in the phonebook
    while read line; do
      echo "$line"
    done < $PHONEBOOK_ENTRIES
  fi

elif [ "$1" = "lookup" ]; then
  # empty phonebook
  if [ ! -e $PHONEBOOK_ENTRIES ] || [ ! -s $PHONEBOOK_ENTRIES ]; then
    echo "phonebook is empty"
  else
    # display all phone numbers associated with given name
    while read line; do
      words=($line)

      # check if name in file matches given name
      if [ "${words[0]}" = "$2" ] && [ "${words[1]}" = "$3" ]; then
        echo "${words[2]}"
      fi
    done < $PHONEBOOK_ENTRIES
  fi

elif [ "$1" = "remove" ]; then
  # empty phonebook
  if [ ! -e $PHONEBOOK_ENTRIES ] || [ ! -s $PHONEBOOK_ENTRIES ]; then
    echo "phonebook is empty"
  else
    # delete all entries associated with given name
    sed -i "/$2 $3/d" $PHONEBOOK_ENTRIES
  fi

elif [ "$1" = "clear" ]; then
  # delete the entire phonebook
  rm $PHONEBOOK_ENTRIES

else
  # display valid commands
  echo "Please enter a valid command:"
  for option in "${!options[@]}"; do
    echo "$option - ${options[$option]}"
  done

fi