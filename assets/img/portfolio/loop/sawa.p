from PIL import Image
import os

def resize_images(folder_path, target_height=600):
    """Resizes all images in the folder to have a consistent height while maintaining the aspect ratio."""
    
    valid_extensions = (".jpg", ".jpeg", ".png", ".webp")  # Image formats to process
    images = [f for f in os.listdir(folder_path) if f.lower().endswith(valid_extensions)]
    
    if not images:
        print("No image files found in the directory.")
        return

    for image_name in images:
        image_path = os.path.join(folder_path, image_name)
        
        try:
            with Image.open(image_path) as img:
                # Calculate new width while maintaining aspect ratio
                aspect_ratio = img.width / img.height
                new_width = int(target_height * aspect_ratio)
                
                # Resize image
                img_resized = img.resize((new_width, target_height), Image.LANCZOS)
                
                # Save the resized image (overwrite the original)
                img_resized.save(image_path)
                
                print(f"Resized: {image_name} → {new_width}x{target_height}px")
        
        except Exception as e:
            print(f"Error processing {image_name}: {e}")

# Example usage
folder_path = "/home/gcl/Downloads/getu-ictt/assets/img/portfolio/loop"  # Update with the actual folder path
resize_images(folder_path)
