function layout() {
    return {
        name: "Four Corners",
        getFrameAssignments: (windows, screenFrame) => {
            const fullCornerHeight = screenFrame.height / 2;
            const fullCornerWidth = screenFrame.width / 2;

            let remainderHeight = 0;
            const remainderWidth = fullCornerWidth;

            if (windows.length > 4) {
                remainderHeight = fullCornerHeight / (windows.length - 3);
            }

            const frames = windows.map((window, index) => {
                if (windows.length == 1) {
                    // If there is only one window, it should take up the full screen
                    const frame = {
                        x: screenFrame.x,
                        y: screenFrame.y,
                        width: screenFrame.width,
                        height: screenFrame.height
                    };
                    return { [window.id]: frame };
                } else if (windows.length == 2) {
                    // If there are two windows, they should each take up half of the screen
                    if (index == 0) {
                        const frame = {
                            x: screenFrame.x,
                            y: screenFrame.y,
                            width: fullCornerWidth,
                            height: screenFrame.height
                        };
                        return { [window.id]: frame };
                    } else {
                        const frame = {
                            x: screenFrame.x + fullCornerWidth,
                            y: screenFrame.y,
                            width: fullCornerWidth,
                            height: screenFrame.height
                        };
                        return { [window.id]: frame };
                    }
                } else if (windows.length == 3) {
                    // If there are three windows, the first window should take up the left half of the screen, and the other two should take up the right half
                    if (index == 0) {
                        const frame = {
                            x: screenFrame.x,
                            y: screenFrame.y,
                            width: fullCornerWidth,
                            height: screenFrame.height
                        };
                        return { [window.id]: frame };
                    } else if (index == 1) {
                        const frame = {
                            x: screenFrame.x + fullCornerWidth,
                            y: screenFrame.y,
                            width: fullCornerWidth,
                            height: fullCornerHeight
                        };
                        return { [window.id]: frame };
                    } else {
                        const frame = {
                            x: screenFrame.x + fullCornerWidth,
                            y: screenFrame.y + fullCornerHeight,
                            width: fullCornerWidth,
                            height: fullCornerHeight
                        };
                        return { [window.id]: frame };
                    }
                } else if (index <= 2 || index == 3 && windows.length == 4) {
                    // If there are four windows, they should each take up a quarter of the screen
                    const frame = {
                        x: screenFrame.x + (fullCornerWidth * (index % 2)),
                        y: screenFrame.y + (fullCornerHeight * Math.floor(index / 2)),
                        width: fullCornerWidth,
                        height: fullCornerHeight
                    };
                    return { [window.id]: frame };
                } else {
                    // If there are more than four windows, the first three should take up the top left, top right, bottom left of the screen, and the rest should take up the bottom right of the screen
                    const frame = {
                        x: screenFrame.x + fullCornerWidth,
                        y: screenFrame.y + fullCornerHeight + (remainderHeight * (index - 3)),
                        width: remainderWidth,
                        height: remainderHeight
                    }
                    return { [window.id]: frame };
                }
            });
            return frames.reduce((frames, frame) => ({ ...frames, ...frame }), {});
        }
    };
}