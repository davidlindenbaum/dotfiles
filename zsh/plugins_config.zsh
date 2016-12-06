ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^ ' autosuggest-accept

# Widgets that accept the entire suggestion
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
	end-of-line
	vi-forward-char
	vi-end-of-line
	vi-add-eol
)

# Widgets that accept the suggestion as far as the cursor moves
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-char
	forward-word
	vi-forward-word
	vi-forward-word-end
	vi-forward-blank-word
	vi-forward-blank-word-end
)


#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
#ZSH_HIGHLIGHT_STYLES[comment]='fg=8'
#ZSH_HIGHLIGHT_STYLES[globbing]='none'
#ZSH_HIGHLIGHT_STYLES[path]='none'
