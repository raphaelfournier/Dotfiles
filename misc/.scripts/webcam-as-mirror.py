#!/usr/bin/env python3

import os
import cv2
import subprocess

def list_video_devices():
    """Lists video devices connected to the system."""
    video_devices = []
    for dev in os.listdir('/dev'):
        if dev.startswith('video'):
            video_devices.append(f'/dev/{dev}')
    return sorted(video_devices)  # Sort to ensure consistent ordering

def get_device_name(device):
    """Gets the name of the video device using v4l2-ctl."""
    try:
        output = subprocess.check_output(["v4l2-ctl", "--device", device, "--info"], stderr=subprocess.DEVNULL)
        return output.decode().split("\n")[0]  # Extract the first line as device name
    except Exception as e:
        return "Unknown Device"

def find_webcam():
    """Prioritize external webcam if available."""
    devices = list_video_devices()
    if not devices:
        print("No webcam detected!")
        return None

    # List external first by checking device names
    for device in devices:
        device_name = get_device_name(device)
        if "USB" in device_name or "external" in device_name.lower():
            return device

    # Fallback to the first device
    return devices[0]

def use_webcam_as_mirror(device):
    """Uses OpenCV to display webcam feed as a mirror."""
    cap = cv2.VideoCapture(device)
    if not cap.isOpened():
        print(f"Failed to open webcam: {device}")
        return

    print(f"Using webcam: {device}")

    while True:
        ret, frame = cap.read()
        if not ret:
            print("Failed to read frame!")
            break

        # Flip the frame horizontally to act as a mirror
        mirror_frame = cv2.flip(frame, 1)

        cv2.imshow("Webcam Mirror", mirror_frame)

        # Exit on pressing 'q'
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    selected_device = find_webcam()
    if selected_device:
        use_webcam_as_mirror(selected_device)

