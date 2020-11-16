# ios-exercise-ext
Here is simple text input to get a query string form the user. This query is used for fetching images form external API. After tap on "SEARCH" button, app will call API and return a collection of images metadata. Your task is:

1. Rewrite ImageMetadataParser and ImageMetadata in latest Swift version. The classes interfaces should stay as they are. You can add private variables and methods if you need some.

2. Currently class ImageMetadata contains url property for image url in "small" size. Collect and store as new property all available urls in json API response (raw, full, regular, thumb). Use Swift enum type to define the size of image. Implement new method in ImageMetadata which returns Bool to compare image sizes values e.g. small < full

3. Write unit tests for ImageMetadataParser class interface.

4. Create and present a new ViewController in didTapSearchButton to display images form fetched url's in two variants ("small" and "full"). 

See attached wireframe. It dosen't have to be a pixel perfect implementation, this is only a guide what needs to be displayed: 
- provided query as a UILabel at the top
- image size switch as UISegmentedControll below
- collection of downloaded images

5. Provide method implemntation in ImageProvider for image downloading. Details in a TODO comment in code.
 - (void)getImageFromUrl:(NSURL *)url useCache:(BOOL)useCache completion:(void(^)(UIImage *, NSURL *))completion


6. Fix known issue in code. There is an issue with endless path in method provided below. Make sure all possible casses are covered and we are always ending with completion block.
 - (void)getDataFromURL:(NSURL *)url completion: (void(^)(NSDictionary *))completion


7. Use coresponding image color form ImageMetadata to display a placeholder on collection item when image is downloading.

8. Use your best Architectural approach to solve MVC issues if any.

![Alt text](design.png?raw=true "Wireframe")

Create a separate branch named `exercise-solution` from master, and open a Pull Request.
