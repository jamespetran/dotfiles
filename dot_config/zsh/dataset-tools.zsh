# Dataset Analysis Tools - Rust-grade reliability and performance
# These functions embody Rust's philosophy: explicit error handling, zero-cost abstractions, performance

# Smart dataset preview with automatic format detection
dv() {
    local file="$1"
    
    # Input validation (Rust-style defensive programming)
    if [[ -z "$file" ]]; then
        echo "Error: No file specified" >&2
        echo "Usage: dv <file>" >&2
        return 1
    fi
    
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' does not exist" >&2
        return 1
    fi
    
    local ext="${file##*.}"
    local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    
    echo "📊 Dataset: $file ($(numfmt --to=iec --suffix=B $size))"
    
    # Pattern matching on file extensions (Rust-style match)
    case "${ext,,}" in
        json)
            echo "🔍 JSON Analysis:"
            if command -v jq >/dev/null 2>&1; then
                echo "Structure:"
                head -1000 "$file" | jq 'keys // type' 2>/dev/null || echo "Invalid JSON format"
                echo "Sample:"
                head -5 "$file" | jq '.' 2>/dev/null || cat "$file" | head -5
            else
                echo "Install jq for better JSON analysis"
                head -10 "$file"
            fi
            ;;
        csv)
            echo "📈 CSV Analysis:"
            echo "Columns: $(head -1 "$file" | tr ',' '\n' | wc -l)"
            echo "Rows: $(wc -l < "$file")"
            echo "Header:"
            head -1 "$file" | tr ',' '\n' | nl
            echo "Sample data:"
            head -5 "$file" | column -t -s ','
            ;;
        parquet)
            echo "🗃️  Parquet Analysis:"
            if command -v parquet-tools >/dev/null 2>&1; then
                parquet-tools schema "$file"
                echo "Sample:"
                parquet-tools head -n 5 "$file"
            else
                echo "Install parquet-tools for Parquet analysis"
            fi
            ;;
        jsonl|ndjson)
            echo "📝 JSONL Analysis:"
            echo "Lines: $(wc -l < "$file")"
            echo "Sample structure:"
            head -3 "$file" | jq '.' 2>/dev/null || head -3 "$file"
            ;;
        txt|log)
            echo "📄 Text Analysis:"
            echo "Lines: $(wc -l < "$file")"
            echo "Words: $(wc -w < "$file")"
            echo "Characters: $(wc -c < "$file")"
            echo "Sample:"
            head -10 "$file"
            ;;
        *)
            echo "🔍 Binary/Unknown Format Analysis:"
            file "$file"
            echo "Size: $(ls -lh "$file" | awk '{print $5}')"
            if command -v hexdump >/dev/null 2>&1; then
                echo "Header (hex):"
                hexdump -C "$file" | head -5
            fi
            ;;
    esac
}

# Dataset statistics with error handling
dstats() {
    local dir="${1:-.}"
    
    if [[ ! -d "$dir" ]]; then
        echo "Error: Directory '$dir' does not exist" >&2
        return 1
    fi
    
    echo "📊 Dataset Statistics for: $dir"
    echo "═══════════════════════════════════════"
    
    # Total files and size
    local total_files=$(find "$dir" -type f | wc -l)
    local total_size=$(du -sh "$dir" 2>/dev/null | cut -f1)
    
    echo "Total files: $total_files"
    echo "Total size: $total_size"
    echo
    
    # File type breakdown
    echo "📁 File Types:"
    find "$dir" -type f -name "*.*" | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -10
    echo
    
    # Size distribution
    echo "💾 Size Distribution:"
    find "$dir" -type f -exec stat -f%z {} \; 2>/dev/null | awk '
    {
        if ($1 < 1024) small++
        else if ($1 < 1048576) medium++
        else if ($1 < 1073741824) large++
        else huge++
        total++
    }
    END {
        printf "< 1KB:   %d (%.1f%%)\n", small, small/total*100
        printf "< 1MB:   %d (%.1f%%)\n", medium, medium/total*100
        printf "< 1GB:   %d (%.1f%%)\n", large, large/total*100
        printf "> 1GB:   %d (%.1f%%)\n", huge, huge/total*100
    }'
}

# Intelligent file search for datasets
dfind() {
    local pattern="$1"
    local dir="${2:-.}"
    
    if [[ -z "$pattern" ]]; then
        echo "Error: No search pattern specified" >&2
        echo "Usage: dfind <pattern> [directory]" >&2
        return 1
    fi
    
    echo "🔍 Searching for datasets matching: '$pattern'"
    
    # Use fd for fast file finding, fallback to find
    if command -v fd >/dev/null 2>&1; then
        fd -t f "$pattern" "$dir" -x echo "📄 {}" \; -x dv {} \; -x echo ""
    else
        find "$dir" -type f -name "*$pattern*" -exec echo "📄 {}" \; -exec dv {} \; -exec echo "" \;
    fi
}

# Dataset quality checks
dcheck() {
    local file="$1"
    
    if [[ -z "$file" || ! -f "$file" ]]; then
        echo "Error: File '$file' does not exist" >&2
        return 1
    fi
    
    echo "🔍 Dataset Quality Check: $file"
    echo "═══════════════════════════════════════"
    
    local ext="${file##*.}"
    
    case "${ext,,}" in
        json)
            echo "✅ JSON Validation:"
            if jq empty "$file" 2>/dev/null; then
                echo "   Valid JSON format"
                echo "   Keys: $(jq 'keys // empty' "$file" 2>/dev/null | tr -d '[]," ' | tr '\n' ' ')"
            else
                echo "   ❌ Invalid JSON format"
            fi
            ;;
        csv)
            echo "✅ CSV Validation:"
            local header_cols=$(head -1 "$file" | tr ',' '\n' | wc -l)
            local inconsistent_rows=$(awk -F',' -v expected="$header_cols" 'NF != expected {print NR}' "$file" | wc -l)
            
            if [[ $inconsistent_rows -eq 0 ]]; then
                echo "   Consistent column count: $header_cols"
            else
                echo "   ⚠️  Inconsistent rows: $inconsistent_rows"
            fi
            
            # Check for empty values
            local empty_cells=$(grep -o ',,' "$file" | wc -l)
            if [[ $empty_cells -gt 0 ]]; then
                echo "   ⚠️  Empty cells detected: $empty_cells"
            else
                echo "   No empty cells"
            fi
            ;;
        *)
            echo "📄 File integrity:"
            if [[ -s "$file" ]]; then
                echo "   Non-empty file ✅"
            else
                echo "   ❌ Empty file"
            fi
            ;;
    esac
    
    # Check for common issues
    if grep -q '\0' "$file" 2>/dev/null; then
        echo "   ⚠️  Contains null bytes (binary data?)"
    fi
    
    if [[ $(wc -c < "$file") -eq 0 ]]; then
        echo "   ❌ Zero-byte file"
    fi
    
    echo "✅ Quality check complete"
}

# Batch process datasets with progress tracking
dbatch() {
    local operation="$1"
    shift
    local files=("$@")
    
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "Error: No files specified" >&2
        echo "Usage: dbatch <operation> <file1> [file2...]" >&2
        return 1
    fi
    
    echo "🔄 Batch processing ${#files[@]} files..."
    
    local completed=0
    local failed=0
    
    for file in "${files[@]}"; do
        echo -n "Processing: $file... "
        
        case "$operation" in
            check)
                if dcheck "$file" >/dev/null 2>&1; then
                    echo "✅"
                    ((completed++))
                else
                    echo "❌"
                    ((failed++))
                fi
                ;;
            stats)
                if dv "$file" >/dev/null 2>&1; then
                    echo "✅"
                    ((completed++))
                else
                    echo "❌"
                    ((failed++))
                fi
                ;;
            *)
                echo "❌ Unknown operation: $operation"
                ((failed++))
                ;;
        esac
    done
    
    echo
    echo "📊 Batch Results:"
    echo "   Completed: $completed"
    echo "   Failed: $failed"
    echo "   Success rate: $(( completed * 100 / (completed + failed) ))%"
}