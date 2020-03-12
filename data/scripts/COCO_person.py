from pycocotools.coco import COCO
import os
import shutil
import json

if __name__ == "__main__":
    os.chdir("../coco/")
    
    ann_names = [
        "annotations/instances_train2017.json",
        "annotations/instances_val2017.json"
        ]
    
    for ann in ann_names:
        coco = COCO(ann)
          
        category_ids = coco.getCatIds(catNms=["person"])
        
        # Delete all annotations of given category
        print("Loading", ann)
        with open(ann) as ann_file:
            x = json.load(ann_file)
        
        print("Deleting categories")
        x["categories"] = [i for i in x["categories"] if i["id"] in category_ids]
        x["annotations"] = [i for i in x["annotations"] if i["category_id"] in category_ids]
        
        new_ann = ann[:-5] + "_person.json"
        print("Writing", new_ann)
        with open(new_ann, 'w') as new_ann_file:
            json.dump(x, new_ann_file)
