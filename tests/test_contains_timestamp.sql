BEGIN;

SELECT plan(4);

SET search_path TO public, _rrule;

SELECT is(
  contains_timestamp(
    '
    DTSTART:19970902T090000
    RRULE:FREQ=WEEKLY;UNTIL=19980902T090000
    '::TEXT::RRULESET,
    '19980602T090000'::timestamp
  ),
  true,
  'when timestamp is contained by ruleset.'
);

SELECT is(
  '
  DTSTART:19970902T090000
  RRULE:FREQ=WEEKLY;UNTIL=19980902T090000
  '::TEXT::RRULESET
  @>
  '19980602T090000'::timestamp,
  true,
  'when timestamp is NOT contained by ruleset (@> operator).'
);

SELECT is(
  contains_timestamp(
    '
    DTSTART:19970902T090000
    RRULE:FREQ=WEEKLY;UNTIL=19980902T090000
    '::TEXT::RRULESET,
    '19980603T090000'::timestamp
  ),
  false,
  'when timestamp is NOT contained by ruleset.'
);

SELECT is(
    '
    DTSTART:19970902T090000
    RRULE:FREQ=WEEKLY;UNTIL=19980902T090000
    '::TEXT::RRULESET
    @> '19980603T090000'::timestamp,
  false,
  'when timestamp is NOT contained by ruleset (@> operator).'
);

SELECT * FROM finish();

ROLLBACK;