# Collection-Prototype

I used `NSLayoutConstraint` instead of `SnapKit` since I was having issues importing it, but using `SnapKit` for the constraints (except the rising animation) should work here.

## Explanation of the Rising Animation
I discussed this during my final EoD presentation, but we can create two `NSLayoutConstraint` objects and set them to the constraints based on where the view should start and end. Then, we can animate the view rising by toggling the constraints.

## Explanation of the Swipe Animation
This can be achieved by having a plain white view that is added as a subview above all other subviews. Then, in the `visibleItemsInvalidationHandler`, we can manipulate the `alpha` value of the white view based on the distance the card is from the center of the `CollectionView`. 

https://github.com/user-attachments/assets/18901d63-aed5-41c6-a848-f0bf380105d9
