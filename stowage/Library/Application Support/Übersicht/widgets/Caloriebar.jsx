/*
 * Filename: Caloriebar.jsx
 * Author: "Berry"
 * License: CC0
 * Description: An Übersicht 1.6 (72) widget designed to be used as a polybar/lemonbar/etc style bar with yabai under macOS.
 * If you enjoy this program, please consider donating towards Red Panda conservation efforts.
 */

// the command output will be split based on this pattern
const TOKEN = "-*-";

// this is executed every `refreshFrequency' ms
export const command = `
/opt/homebrew/bin/yabai -m query --spaces ; echo "${TOKEN}" ;
date +"%I:%M %p ${TOKEN} %a %d/%m/%Y"
`;

export const refreshFrequency = 100;

// represented in https://emotion.sh/
export const className =`
position: relative;
user-select: none;
cursor: default;
-webkit-user-drag: none;
margin: 8px;
top: 0;
left: 0;

font-family: "SF Pro";
font-size: 0.9rem;

main {
  display: flex;
  flex-direction: row;
  background: #222222;
  height: 22px;
  align-items: center;
  color: white;
}

.end {
  justify-self: flex-end;
  margin-left: auto;
  margin-right: 12px;
}

.workspaces {
  list-style-type: none;
  padding: 0 6px 0 6px;
  margin: 0;
  position: relative;
}

.workspace {
  display: inline;
  margin: 0 8px 0 8px;
  position: relative;
  z-index: 1;
}

.workspace.visible {
  color: #222222;
}

.workspace.fullscreen {
  color: #999;
}

.cursor {
  background: #555;
  border-radius: 12px;
  z-index: 0;
  width: 32px;
  height: 100%;
  position: absolute;
  left: 4px;
  transition: all .2s;
}

/* 29px increments!                                 */
/* x offset = 29px * (n - 1) where n = nth-child(n) */

.workspace.visible:nth-child(1) ~ .cursor {
  transform: translateX(calc(29px * 0));
}

.workspace.visible:nth-child(2) ~ .cursor {
  transform: translateX(calc(29px * 1));
}

.workspace.visible:nth-child(3) ~ .cursor {
  transform: translateX(calc(29px * 2));
}

.workspace.visible:nth-child(4) ~ .cursor {
  transform: translateX(calc(29px * 3));
}

.workspace.visible:nth-child(5) ~ .cursor {
  transform: translateX(calc(29px * 4));
}
`

export const render = ({output}) => {
  let split = output.split(TOKEN);
  let {workspaces, time, date} = {
    workspaces: JSON.parse(split[0]),
    time: split[1],
    date: split[2]
  }
  return (
    <main>
      <ul className="workspaces">
        {
          workspaces.map(s => {
	    return <li className={`workspace ${s['is-visible'] ? 'visible' : ''} ${s['is-native-fullscreen'] ? 'fullscreen' : ''}`}>
		     { s['is-native-fullscreen'] ? '■' : '●' }
		   </li>
	  })
        }
	<span class="cursor"></span>
      </ul>
      <span class="end">
	{ time }
      </span>
    </main>
  );
}

