function unlock_bw
    set -gx BW_SESSION "$(bw unlock (secret-tool lookup domain bitwarden) --raw)"
end
