function bw_unlock_on_startup
  if command -v bw &> /dev/null
    function _bw_unlock_internal
      set -l password (pass bitwarden_master_password)
      set -l session_key (bw unlock --raw "$password")
      if test -n "$session_key"
        set -gx BW_SESSION "$session_key"
        history --delete --exact --case-sensitive "bw unlock --raw"
        echo "Bitwarden unlocked (session key stored in BW_SESSION)."
      else
        echo "Bitwarden unlock failed."
      end
    end
    _bw_unlock_internal
    functions --erase _bw_unlock_internal
  else
    echo "Bitwarden CLI (bw) is not installed. Please install it to unlock your vault."
  end
end
