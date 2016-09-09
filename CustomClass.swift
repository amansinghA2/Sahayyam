//
//  CustomClass.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomClass: NSObject {

    class func DataFilter(categoryArray:[CategoryList]) -> [CategoryList]{
        
        var filteredLists = [CategoryList]()
         filteredLists = categoryArray.filter({
            if $0.parent_id == "0" {
                for category in categoryArray{
                    if $0.category_id == category.parent_id{
                        if !(category.products == "0") {
                            return true
                        }
                    }
                }
            }
            
            if !($0.products == "0") {
                return true
            }
            return false
        })
        
        return filteredLists
        
    }
    
    class func htmlTrimmed(text:String) -> String {
        let trimmedString = text.stringByReplacingOccurrencesOfString("<[^>]+>", withString: " , ", options: .RegularExpressionSearch, range: nil)
        
        return trimmedString
    }
    
    
//    try {
//    JSONArray categories;
//    Log.d("MainActivity", "Categories:------->>>> "+sm.getCategoriesJson());
//    jsonObjCategories = new JSONObject(sm.getCategoriesJson());
//    categories = jsonObjCategories.getJSONArray("category");
//    
//    for (int i=0; i<categories.length(); i++){
//    jsonObjCategories = categories.getJSONObject(i);
//    /*if(jsonObjCategories.getString("products").equals("0")){
//     
//     }else {*/
//    mCategoryName.add(jsonObjCategories.getString("name"));
//    mCategoryId.add(jsonObjCategories.getString("category_id"));
//    mParentCategory.add(jsonObjCategories.getString("parent_id"));
//    mNosProducts.add(jsonObjCategories.getString("products"));
//    // }
//    }
//    } catch (JSONException e) {
//    e.printStackTrace();
//    }
//    
//    final List<Map<String, String>> groupData = new ArrayList<Map<String, String>>();
//    final List<List<Map<String, String>>> childData = new ArrayList<List<Map<String, String>>>();
//    
//    final List<String> parentId = new ArrayList<String>();
//    final List<String> childId = new ArrayList<String>();
//    
//    for(int i = 0; i < mCategoryName.size(); i++ ){
//    String strCatName = mCategoryName.get(i).toString();
//    String strCatId = mCategoryId.get(i).toString();
//    
//    strCatName = strCatName.replaceAll("&nbsp;","").replaceAll("&amp;", "&");
//    
//    if(mParentCategory.get(i).equals("0")){
//    if(hasChildWithProducts(i)) {
//    Map<String, String> curgroupMap1 = new HashMap<String, String>();
//    groupData.add(curgroupMap1);
//    curgroupMap1.put("parent", strCatName);
//    //parent Id
//    parentId.add(strCatId);
//    }else{
//    continue;
//    }
//    
//    }
//    
//    boolean hasChildWithProducts(int val){
//    for(int i = 0; i<mCategoryId.size(); i++){
//    if(mCategoryId.get(val).equals(mParentCategory.get(i))){
//    if(!mNosProducts.get(i).equals("0")){
//    return true;
//    }
//    }
//    }
//    if(mNosProducts.get(val).equals("0"))
//    return false;
//    else
//    return true;
//    }
    
}
