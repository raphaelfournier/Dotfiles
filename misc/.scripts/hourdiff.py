#! /bin/env python

import argparse
from datetime import datetime

def parse_french_time(time_str):
    """Converts French time format (e.g., 18h25) to a datetime object."""
    return datetime.strptime(time_str, "%Hh%M")

def time_difference(time1, time2):
    """Calculates the difference between two times in hours and minutes."""
    # Parse the times
    t1 = parse_french_time(time1)
    t2 = parse_french_time(time2)
    
    # Calculate the difference in seconds
    diff = abs((t1 - t2).total_seconds())
    
    # Convert the difference to hours and minutes
    hours = diff // 3600
    minutes = (diff % 3600) // 60
    
    return int(hours), int(minutes)

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Calculate time difference between two French-format times.")
    parser.add_argument("time1", type=str, help="The first time in French format (e.g., 18h25)")
    parser.add_argument("time2", type=str, help="The second time in French format (e.g., 13h15)")
    
    # Parse the arguments
    args = parser.parse_args()
    
    # Calculate time difference
    hours, minutes = time_difference(args.time1, args.time2)
    
    # Output the result
    print(f"Difference: {hours} hours and {minutes} minutes")

if __name__ == "__main__":
    main()
