# Pywal wrapper function with automatic selection color generation
wal() {
    # Run pywal with all arguments
    command wal "$@"
    
    # If pywal succeeded, run post-processing
    if [ $? -eq 0 ]; then
        # Run the post-run script if it exists
        if [ -x ~/.config/wal/postrun.sh ]; then
            ~/.config/wal/postrun.sh
        fi
    fi
}
