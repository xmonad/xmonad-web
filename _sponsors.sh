#!/usr/bin/env bash

set -eu -o pipefail
shopt -s lastpipe inherit_errexit

function o { printf -->&2 "%s:%s\\n" "${0##*/}" "$(printf " %q" "$@")"; "$@"; }

function gh-org-sponsors-monthly-tiers {
	# shellcheck disable=SC2016
	gh api graphql --paginate -F org="${1:?org}" -f query='
		query Tiers($endCursor: String, $org: String!) {
			organization(login: $org) {
				... on Sponsorable {
					sponsorsListing {
						tiers(first: 100, after: $endCursor) {
							nodes {
								id
								name
								description
								isOneTime
								monthlyPriceInDollars
							}
							pageInfo { hasNextPage, endCursor }
						}
					}
				}
			}
		}
	' --jq '.data.organization.sponsorsListing.tiers.nodes[] | select(.isOneTime | not)'
}

function gh-org-sponsorships {
	# shellcheck disable=SC2016
	gh api graphql --paginate -F org="${1:?org}" -f query='
		query Sponsors($endCursor: String, $org: String!) {
			organization(login: $org) {
				... on Sponsorable {
					sponsorshipsAsMaintainer(first: 100, includePrivate: true, after: $endCursor) {
						nodes {
							sponsorEntity {
								... on User         { login, name, url, websiteUrl }
								... on Organization { login, name, url, websiteUrl }
							}
							tier {
								closestLesserValueTier { id }
							}
							privacyLevel
						}
						pageInfo { hasNextPage, endCursor }
					}
				}
			}
		}
	' --jq '.data.organization.sponsorshipsAsMaintainer.nodes[]'
}

function jq-tierids-since {
	jq --arg since "${1:?since}" -s -r 'until(.[0].description | contains($since); del(.[0])) | .[].id'
}

function jq-filter-privacylevel {
	jq --arg level "${1:?level}" 'select(.privacyLevel == $level)'
}

function jq-filter-tier {
	jq --arg tier "${1:?tier}" 'select(.tier.closestLesserValueTier.id == $tier)'
}

function jq-sort-by {
	jq -s "sort_by(.${1:?key}) | .[]"
}

function named-sponsors {
	public_sponsorships=$(
		GITHUB_TOKEN="${ADMIN_GITHUB_TOKEN:?}" \
		o gh-org-sponsorships "${1:?org}" \
		| jq-filter-privacylevel PUBLIC \
		| jq-sort-by sponsorEntity.login \
		| jq -s ''
	)
	GITHUB_TOKEN="${ADMIN_GITHUB_TOKEN:?}" \
	o gh-org-sponsors-monthly-tiers "${1:?org}" \
	| jq-tierids-since XMonad.Layout.Named \
	| tac \
	| while read -r tier; do
		<<<"$public_sponsorships" jq '.[]' | jq-filter-tier "$tier" | jq '.sponsorEntity'
	done \
	| jq -s ''
}

"$@"
