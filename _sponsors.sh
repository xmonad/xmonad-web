#!/usr/bin/env bash

set -eu -o pipefail
shopt -s lastpipe inherit_errexit

function o { printf -->&2 "%s:%s\\n" "${0##*/}" "$(printf " %q" "$@")"; "$@"; }

function gh-org-sponsors-tiers {
	# shellcheck disable=SC2016
	gh api graphql -F org="${1:?org}" -f query='
		query Tiers($org: String!) {
			organization(login: $org) {
				... on Sponsorable {
					sponsorsListing {
						tiers(first: 100) {
							nodes {
								id
								name
								description
								monthlyPriceInDollars
							}
						}
					}
				}
			}
		}
	' --jq '.data.organization.sponsorsListing.tiers.nodes[]'
}

function gh-org-sponsors-at-tier {
	# shellcheck disable=SC2016
	gh api graphql --paginate -F org="${1:?org}" -F tier="${2:?tier}" -f query='
		query Sponsors($endCursor: String, $org: String!, $tier: ID!) {
			organization(login: $org) {
				... on Sponsorable {
					sponsors(first: 100, tierId: $tier, after: $endCursor) {
						nodes {
							... on User         { login, name, url, websiteUrl }
							... on Organization { login, name, url, websiteUrl }
						}
						pageInfo {
							hasNextPage
							endCursor
						}
					}
				}
			}
		}
	' --jq '.data.organization.sponsors.nodes[]'
}

function gh-org-sponsors {
	# shellcheck disable=SC2016
	gh api graphql --paginate -F org="${1:?org}" -f query='
		query Sponsors($endCursor: String, $org: String!) {
			organization(login: $org) {
				... on Sponsorable {
					sponsors(first: 100, after: $endCursor) {
						nodes {
							... on User         { login, name, url, websiteUrl }
							... on Organization { login, name, url, websiteUrl }
						}
						pageInfo {
							hasNextPage
							endCursor
						}
					}
				}
			}
		}
	' --jq '.data.organization.sponsors.nodes[]'
}

function jq-tierids-since {
	jq --arg since "${1:?since}" -s -r 'until(.[0].description | contains($since); del(.[0])) | .[].id'
}

function jq-sort-by {
	jq -s "sort_by(.${1:?key}) | .[]"
}

function named-sponsors {
	o gh-org-sponsors-tiers "${1:?org}" | jq-tierids-since XMonad.Layout.Named | tac | \
		while read -r tier; do
			o gh-org-sponsors-at-tier "${1:?org}" "$tier" | jq-sort-by login
		done | \
		jq -s ''
}

"$@"
