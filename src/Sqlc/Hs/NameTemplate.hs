-- | Minimal mustache-style template rendering for generated-code names.
--
-- Supports exactly one construct: @{{variable}}@ (whitespace inside the
-- braces is ignored), replaced by the variable's value from the context.
-- Unknown variables render as the empty string, mirroring mustache's
-- behaviour. There are deliberately no sections, no escaping and no nested
-- lookups — names are short and the conditional cases (e.g. the table prefix
-- of a field name) are precomputed into context variables instead.
module Sqlc.Hs.NameTemplate
  ( render,
  )
where

import Data.List qualified
import Data.Text qualified

-- | @render context template@ substitutes every @{{var}}@ in @template@ with
-- its value from @context@.
--
-- >>> render [("query", "ListUsers")] "query_{{query}}"
-- "query_ListUsers"
render :: [(Text, Text)] -> Text -> Text
render context = go
  where
    go template =
      case Data.Text.breakOn "{{" template of
        (before, "") ->
          before
        (before, rest) ->
          case Data.Text.breakOn "}}" (Data.Text.drop 2 rest) of
            -- Unterminated "{{": emit it verbatim.
            (_, "") ->
              before <> Data.Text.take 2 rest <> go (Data.Text.drop 2 rest)
            (variable, closed) ->
              before
                <> lookupVariable (Data.Text.strip variable)
                <> go (Data.Text.drop 2 closed)

    lookupVariable variable =
      fromMaybe "" (Data.List.lookup variable context)
