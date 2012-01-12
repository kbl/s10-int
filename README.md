# Integration Exercise: Mail Servers
## TODO lists

Basic todo lists which could be managed with email. Protocol is using only sender email and subject of the message, body or atachements are ignored.

## API
Types of messages described below show all valid email subjects, any other won't be properly interpreted by Maildo. $tokens$ shows parts of subject that could be changed. All errors are reported via emails.

- SUBSCRIBE [$list-id$] - sender of this message will be subscribed to list of passed id (list-id), list-id could only contain alphanumeric caracters and underscore (\w), multiple subscribtions messaegs for already subscribed list causes error,
- ADD [$list-id$] $task$ - adds $task$ to list specified by $list-id$, adding task to list for which subscribption wasn't earlier requested causes error,
- DONE [$list-id$] $task-number$ - rmoves task from list, $task-number$ is 1-based order number of task, removing task from listh for which subscribtion wasn't earlier requested causes error,
- LIST [$list-id$] - lists all tasks on particular list
- UNSUBSCRIBE [$list-id$] - sender of this message will be unsubscribed from list, if sender wasn't previously subscribed this message causes error.

## Installation

TODO
