module Ex01 where

import Codec.Picture (writePng)
import ShapeGraphics

-- For this assignment, you will use the `ShapeGraphics`
-- library. You can (and should) read the source code
-- of the library, provided to you in `ShapeGraphics.hs`,
-- to find out which data types and constructors you should
-- use.
-- An `example` picture, showing the usage of `ShapeGraphics`
-- is provided at the end of the file.



-- PART 1 --

housePic :: Picture
housePic = [house, door, chimney, window]
  where
    houseCoords :: [Point]
    houseCoords = merge houseCOx houseCOy
    house :: PictureObject
    house = Path houseCoords green Solid
    door :: PictureObject
    door  = Path (map convertPoint doorCOs) red Solid
    chimney :: PictureObject
    chimney = Path (map convertPoint chimneyCOs) green Solid

houseCOx :: [Float]
houseCOx = [300.0,300.0,270.0,500.0,730.0,700.0,700.0]
houseCOy :: [Float]
houseCOy = [750.0,450.0,450.0,200.0,450.0,450.0,750.0]

merge :: [Float] -> [Float] -> [Point]
merge xCoords yCoords = map convertPoint ( zip xCoords yCoords )

convertPoint :: (Float, Float) -> Point
convertPoint (x, y) = Point x y

doorCOs :: [(Float, Float)]
doorCOs = [(550, 750), (550, 550), (650, 550), (650, 750)]

chimneyCOs :: [(Float, Float)]
chimneyCOs = [(605, 325), (605, 250), (650, 250), (650, 363)]

windowCOs :: [(Float, Float)]
windowCOs = [(350, 650), (350, 550), (450, 550), (450, 650)]

cyan :: Colour
cyan = Colour 96 192 255 255

window :: PictureObject
window = Polygon (map convertPoint windowCOs) cyan Solid SolidFill

chimneyHouse :: Picture
chimneyHouse = housePic

-- PART 2 --

movePoint :: Point -> Vector -> Point
movePoint (Point x y) (Vector xv yv)
  = Point (x + xv) (y + yv)

movePoints :: [Point] -> Vector -> [Point]
movePoints points vector = map (\x -> movePoint x vector) points

movePictureObject :: Vector -> PictureObject -> PictureObject
movePictureObject vec (Path pPoints pColour pLineStyle) = Path (movePoints pPoints vec) pColour pLineStyle
movePictureObject vec (Circle cPoint cFloat cColour cLinestyle cFillstyle) = Circle (movePoint cPoint vec) cFloat cColour cLinestyle cFillstyle
movePictureObject vec (Ellipse ePoint eFloat1 eFloat2 eFloat3 eColour eLinestyle eFillstyle) = Ellipse (movePoint ePoint vec) eFloat1 eFloat2 eFloat3 eColour eLinestyle eFillstyle
movePictureObject vec (Polygon poPoints poColour poLineStyle poFillstyle) = Polygon (movePoints poPoints vec) poColour poLineStyle poFillstyle

-- PART 3 --

simpleCirclePic :: Colour -> Float -> Picture
simpleCirclePic col n = map (\r -> Circle (Point 400 400) r col Solid SolidFill) [400/n, 2*400/n..400]


-- use 'writeToFile' to write a picture to file "ex01.png" to test your
-- program.
-- e.g., call `writeToFile housePic` or even `writeToFile [window]`,
-- the output image will be in `ex01.png`.

writeToFile pic
  = writePng "ex01.png" (drawPicture 3 pic)



-- EXAMPLE --

-- The following is an example picture, showing the usage of the
-- ShapeGraphics library. Use `writeToFile example` to view it.
example :: Picture
example = [redEllipse, blueEllipse] where
  redEllipse :: PictureObject
  redEllipse =
    Ellipse (Point 400 400) --center
            100             --width
            200             --height
            (pi/4)          --rotation (radians)
            red             --color
            Solid           --line (stroke) style
            SolidFill       --fill style
  blueEllipse :: PictureObject
  blueEllipse =
    Ellipse (Point 400 400) --center
            150             --width
            250             --height
            0.0             --rotation (radians)
            blue            --color
            Solid           --line (stroke) style
            NoFill          --fill style
