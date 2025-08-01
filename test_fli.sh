#!/bin/bash

# Comprehensive Testing Script for fli CLI Tool
# Usage: ./test_fli.sh

set -e

echo "🧪 Starting Comprehensive fli Testing"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
test_passed() {
    echo -e "${GREEN}✅ $1${NC}"
    ((TESTS_PASSED++))
}

test_failed() {
    echo -e "${RED}❌ $1${NC}"
    ((TESTS_FAILED++))
}

test_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

test_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Get the fli project directory
FLI_DIR="/Users/faizdae/Desktop/fli"
TEST_DIR="/tmp/fli_comprehensive_test"

echo -e "${BLUE}📁 Test Directory: $TEST_DIR${NC}"
echo -e "${BLUE}📁 fli Directory: $FLI_DIR${NC}"
echo ""

# Clean up and create test directory
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo "🧹 Test environment prepared"
echo ""

# ============================================================================
# Test 1: Help Command
# ============================================================================
echo "Test 1: Help Command"
echo "--------------------"
if dart run "$FLI_DIR/bin/fli.dart" --help > /dev/null 2>&1; then
    test_passed "Help command works"
else
    test_failed "Help command failed"
fi
echo ""

# ============================================================================
# Test 2: Version Command  
# ============================================================================
echo "Test 2: Version Command"
echo "----------------------"
if dart run "$FLI_DIR/bin/fli.dart" --version > /dev/null 2>&1; then
    test_passed "Version command works"
else
    test_failed "Version command failed"
fi
echo ""

# ============================================================================
# Test 3: Templates Command
# ============================================================================
echo "Test 3: Templates Command"
echo "------------------------"
if dart run "$FLI_DIR/bin/fli.dart" templates > /dev/null 2>&1; then
    test_passed "Templates command works"
else
    test_failed "Templates command failed"
fi
echo ""

# ============================================================================
# Test 4: Create Basic Project
# ============================================================================
echo "Test 4: Create Basic Project"
echo "---------------------------"
test_info "Creating basic project..."
if dart run "$FLI_DIR/bin/fli.dart" create test_basic_app --template=basic > /dev/null 2>&1; then
    test_passed "Basic project created successfully"
    
    # Check if directory exists
    if [ -d "test_basic_app" ]; then
        test_passed "Project directory created"
        
        # Check key files
        if [ -f "test_basic_app/pubspec.yaml" ]; then
            test_passed "pubspec.yaml exists"
        else
            test_failed "pubspec.yaml missing"
        fi
        
        if [ -f "test_basic_app/lib/main.dart" ]; then
            test_passed "main.dart exists"
        else
            test_failed "main.dart missing"
        fi
        
        if [ -d "test_basic_app/lib/core" ]; then
            test_passed "Core directory structure exists"
        else
            test_failed "Core directory missing"
        fi
        
    else
        test_failed "Project directory not created"
    fi
else
    test_failed "Basic project creation failed"
fi
echo ""

# ============================================================================
# Test 5: Create Feature-Driven Project
# ============================================================================
echo "Test 5: Create Feature-Driven Project"
echo "------------------------------------"
test_info "Creating feature-driven project..."
if dart run "$FLI_DIR/bin/fli.dart" create test_feature_app --template=feature_driven > /dev/null 2>&1; then
    test_passed "Feature-driven project created successfully"
    
    if [ -d "test_feature_app/lib/features" ]; then
        test_passed "Features directory exists"
    else
        test_failed "Features directory missing"
    fi
    
    if [ -d "test_feature_app/lib/shared" ]; then
        test_passed "Shared directory exists"
    else
        test_failed "Shared directory missing"
    fi
else
    test_failed "Feature-driven project creation failed"
fi
echo ""

# ============================================================================
# Test 6: Test All Other Templates
# ============================================================================
echo "Test 6: Test All Other Templates"
echo "-------------------------------"
templates=("clean_architecture" "bloc_pattern" "provider_pattern")

for template in "${templates[@]}"; do
    test_info "Testing template: $template"
    if dart run "$FLI_DIR/bin/fli.dart" create "test_${template}_app" --template="$template" > /dev/null 2>&1; then
        test_passed "Template $template works"
    else
        test_failed "Template $template failed"
    fi
done
echo ""

# ============================================================================
# Test 7: Flutter Validation
# ============================================================================
echo "Test 7: Flutter Project Validation"
echo "---------------------------------"
if command -v flutter &> /dev/null; then
    test_info "Flutter is available, testing generated projects..."
    
    # Test basic project
    cd test_basic_app
    test_info "Running flutter pub get on basic project..."
    if flutter pub get > /dev/null 2>&1; then
        test_passed "Basic project dependencies resolved"
        
        test_info "Running flutter analyze on basic project..."
        if flutter analyze > analyze_output.txt 2>&1; then
            test_passed "Basic project passes analysis (with expected lints)"
        else
            # Check if it's just lint warnings
            if grep -q "issues found" analyze_output.txt && ! grep -q "error" analyze_output.txt; then
                test_passed "Basic project has only lint warnings (expected)"
            else
                test_failed "Basic project has serious analysis errors"
            fi
        fi
    else
        test_failed "Basic project dependency resolution failed"
    fi
    cd ..
    
else
    test_warning "Flutter not available, skipping Flutter validation"
fi
echo ""

# ============================================================================
# Test 8: Error Handling
# ============================================================================
echo "Test 8: Error Handling"
echo "---------------------"

# Test invalid template
test_info "Testing invalid template..."
if dart run "$FLI_DIR/bin/fli.dart" create test_invalid --template=invalid_template > /dev/null 2>&1; then
    test_failed "Should reject invalid template"
else
    test_passed "Correctly rejects invalid template"
fi

# Test invalid project name
test_info "Testing invalid project name..."
if dart run "$FLI_DIR/bin/fli.dart" create "Invalid-Name" --template=basic > /dev/null 2>&1; then
    test_failed "Should reject invalid project name"
else
    test_passed "Correctly rejects invalid project name"
fi

# Test existing directory
test_info "Testing existing directory conflict..."
mkdir existing_project
if dart run "$FLI_DIR/bin/fli.dart" create existing_project --template=basic > /dev/null 2>&1; then
    test_failed "Should reject existing directory"
else
    test_passed "Correctly rejects existing directory"
fi
echo ""

# ============================================================================
# Test 9: Code Quality Tests
# ============================================================================
echo "Test 9: fli Code Quality"
echo "-----------------------"
cd "$FLI_DIR"

test_info "Running dart analyze on fli source..."
if dart analyze > /dev/null 2>&1; then
    test_passed "fli source code passes analysis"
else
    test_failed "fli source code has analysis issues"
fi

test_info "Running dart test on fli..."
if dart test > /dev/null 2>&1; then
    test_passed "All fli unit tests pass"
else
    test_failed "Some fli unit tests failed"
fi

test_info "Checking code formatting..."
if dart format --set-exit-if-changed . > /dev/null 2>&1; then
    test_passed "fli code is properly formatted"
else
    test_warning "fli code formatting could be improved"
fi

cd "$TEST_DIR"
echo ""

# ============================================================================
# Test Summary
# ============================================================================
echo "📊 Test Summary"
echo "==============="
echo -e "Total Tests: $((TESTS_PASSED + TESTS_FAILED))"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed! fli is working perfectly!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please check the output above.${NC}"
    exit 1
fi
