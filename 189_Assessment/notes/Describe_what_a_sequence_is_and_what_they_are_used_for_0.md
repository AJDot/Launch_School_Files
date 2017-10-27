# Describe what a sequence is and what they are used for.

A sequence is a function that iterates over successive numeric values according to the rules defined by the user. The sequence can be ascending or descending and the interval defined can be set. A common use case for sequences is to create a unique identifier for rows in a table.

For example, a sequence can be created to increase the value of a user id by 1 every time a new user is inserted into a table. Here is the command create such a sequence.
```sql
CREATE SEQUENCE user_id_seq
SET INTERVAL 1
MINVALUE 1;
```
Though since the default value for INTERVAL and MINVALUE are both 1 and as such are not needed to be specified, it is good to be clear.

```sql
CREATE SEQUENCE complicated_seq
INCREMENT BY 3
MINVALUE 5
MAXVALUE 20
CYCLE;
```