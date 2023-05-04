use_micromamba() {
    if ! test -e /run/current-system/configuration.scm; then
        ENV="$1"
        FILE="${2:-${ENV}.env.yml}"
        PREFIX="${PWD}/.micromamba-${ENV}"
        test -d ${PREFIX} || micromamba create -p "${PREFIX}" --file "${FILE}" --yes
        eval "$(${HOME}/.local/bin/micromamba shell hook -s posix)"
        micromamba activate -p "${PREFIX}"
    fi
}
