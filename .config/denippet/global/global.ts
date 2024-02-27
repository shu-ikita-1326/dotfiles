import { TSSnippet } from "https://deno.land/x/denippet_vim@v0.1.0/loader.ts";

export const snippets: Record<string, TSSnippet> = {
  uuid: {
    prefix: "uuid",
    body: () => crypto.randomUUID(),
  },
  today: {
    prefix: "today",
    body: () => "${CURRENT_YEAR}${CURRENT_MONTH}${CURRENT_DATE}",
  },
  now: {
    prefix: "now",
    body: () => "${CURRENT_YEAR}${CURRENT_MONTH}${CURRENT_DATE}${CURRENT_HOUR}${CURRENT_MINUTE}${CURRENT_SECOND}",
  },
  datetime: {
    prefix: "datetime",
    body: () => "${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE} ${CURRENT_HOUR}:${CURRENT_MINUTE}:${CURRENT_SECOND}",
  },
};
