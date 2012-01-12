# Integration Exercise: Mail Servers
## TODO lists

Basic todo lists which could be managed with email messages. Only author (email address) and subject of the message are important, body or atachements are ignored.

## Legal messages
Types of messages described below show all valid email subjects, any other won't be properly interpreted by Maildo. `tokens` shows parts of subject that could be changed. All errors are reported back via emails. 

Generaly subject could be described as: `ACTION [list-id] (additional data)` (case sensitive).

### Subscribe to list

    SUBSCRIBE [list-id] 

Sender of this message will be subscribed to list identified by `list-id`, `list-id` could only contain alphanumeric characters and underscore (`\w`), multiple subscribtions messaegs for already subscribed list causes error.

### Add task to list

    ADD [list-id] task 
    
Adds `task` to list identified by `list-id`, adding task to list for which subscribption wasn't earlier requested causes error.

### Task done

    DONE [list-id] task-number

Removes task from list, `task-number` is 1-based order number of task, removing task from listh for which subscribtion wasn't earlier requested causes error. Illegal `task-number` causes error.

### List of tasks

    LIST [list-id] 
    
Respond with list of tasks added to list identified by `list-id`. Listing tasks from list to which sender wasn't subscribed causes error.


### Unsubscribing from list

    UNSUBSCRIBE [list-id] 
    
Sender of this message will be unsubscribed from list identified by `list-id`, if sender wasn't previously subscribed this message causes error.

## Configuration & Usage

Maildo uses gmail mailboxes. Three enviroment variables need to be set:

 * `MAILDO_PASS` - password to mailbox 
 * `MAILDO_MAIL` - username eg `rmutodo@gmail.com`
 * `MAILDO_STORE_PATH` - absolute path to existing folder in which files with todo lists will be kept

After successfull configuration following command should do right thing (;

    $ ./bin/maildo

