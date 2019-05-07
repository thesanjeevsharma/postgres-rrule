CREATE OR REPLACE FUNCTION _rrule.rruleset (TEXT)
RETURNS _rrule.RRULESET AS $$
  WITH "dtstart-line" AS (SELECT _rrule.parse_line($1::text, 'DTSTART') as "x")
  SELECT
    (SELECT "x"::timestamp FROM "dtstart-line" LIMIT 1) AS "dtstart",
    ARRAY[_rrule.rrule($1)] "rrule",
    ARRAY[]::_rrule.RRULE[] "exrule",
    NULL::TIMESTAMP[] "rdate",
    NULL::TIMESTAMP[] "exdate",
    NULL::TEXT "timezone";
$$ LANGUAGE SQL IMMUTABLE STRICT;

