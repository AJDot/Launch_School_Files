# PostgreSQL Data Types Practice Questions
## Describe the difference between the `varchar` and `text` data types.

`varchar(n)`: can contain strings up to a length of n. Max of 255.
`text`: can contain string without length restriction.

## Describe the difference between the `integer`, `decimal`, and `real` data types.

`integer`: whole numbers. Non-fractional.
`decimal(precision, scale)`: Non-floating-point fraction values with limited precision.
`real`: floating-point numbers. Can include fractional values.

## What is the largest value that can be stored in an `integer` column?
2147483647

## Describe the difference between the `timestamp` and `date` data types.
`timestamp`: date and time
`date`: date only

## Can a time with a time zone be stored in a column of type `timestamp`?
No, must use `timestamptz`.