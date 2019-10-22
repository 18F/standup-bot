Feature: Time Helper, parsing a string
  I want the time helper to parse a time from a string
  I want the time helper to convert a time to a formatted string

  Scenario Outline: Parsing a string to a time (negative examples)
    Given the string <time_string>
      When I try to parse it
      Then the time should not parse

    Examples:
      | time_string | status     |
      | 8301        | should not |
      | 830         | should not |
      | 830am       | should not |
      | 830 am      | should not |

  Scenario Outline: Parsing a string to a time (positive examples)
    Given the string <time_string>
      When I try to parse it
      Then the time should parse
      And the parsed time and days should be <expected_time_days>

    Examples:
      | time_string           | expected_time_days                                |
      | 8:30                  | 8:30 am Monday,Tuesday,Wednesday,Thursday,Friday  |
      | 0930 Mo Tu Th         | 9:30 am Monday,Tuesday,Thursday                   |
      | 9:30 pm Mo Tu Th      | 9:30 pm Monday,Tuesday,Thursday                   |
      | 1330 W F              | 1:30 pm Wednesday,Friday                          |
      | 1845 Wednesday Friday | 6:45 pm Wednesday,Friday                          |

  # The following scenarios match patterns instead of values
  # known ahead of time.  To match a pattern, they use a
  # "regular expression" to define what they expect.  A good
  # primer on regular expression is available at:
  #
  # http://www.agillo.net/regex-primer-part-1/
  #
  # In a nutshell, these mostly match to digits, using the
  # \d metacharacter.  \d means "one digit", and curly
  # braces indicate a number of times one digit should
  # occur.  So, \d{4} means four digits.
  #
  # Because the database-friendly format is UTC, 9:30 pm
  # should come back as either 0130 during standard
  # time or 0230 during daylight savings time.  The
  # square brackets mean "any one of these characters",
  # so [12] means to match either a 1 or a 2, so this
  # pattern matches 0130 and 0230.

  Scenario Outline: Getting the time in a database-friendly schedule format
    Given the input time <time>
      When I ask for the schedule format
      Then the result matches <pattern>
    Examples:
    | time    | pattern |
    |         | \d{4}   |
    | 9:30 am | 0930    |
    | 9:30 pm | 2130    |

  Scenario Outline: Getting the time in a report-friendly format
    Given the input time <time>
      When I ask for the report format
      Then the result matches <pattern>
    Examples:
    | time    | pattern           |
    |         | \d{4}-\d{2}-\d{2} |
    | 0830    | \d{4}-\d{2}-\d{2} |

  Scenario Outline: Getting the time in a user-friendly display format
    Given the input time <time>
      When I ask for the display format
      Then the result matches <pattern>
    Examples:
    | time    | pattern                    |
    |         | \d{1,2}:\d{2} [ap]m E[SD]T |
    | 0830    | 8:30 am E[SD]T             |

  Scenario Outline: Calculating the reminder time
    Given the database time <time>
      When I set a reminder for <number> minutes
      Then the result is <result>
    Examples:
    | time | number | result |
    | 1230 | 15     | 1215   |
    | 0830 | 45     | 0745   |
