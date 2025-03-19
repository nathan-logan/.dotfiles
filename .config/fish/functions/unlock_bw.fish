function unlock_bw
    set -gx BW_SESSION "$(bw unlock --raw)"
end
