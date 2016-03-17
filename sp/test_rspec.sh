echo "Enter Spec Path"
read -r spec_path
DISPLAY=localhost:1.0 xvfb-run bundle exec rspec $spec_path
