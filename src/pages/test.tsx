import React, { useState, useEffect } from "react";
import ReactQuill from "react-quill";
import "react-quill/dist/quill.snow.css";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
import dynamic from "next/dynamic";
const CKEditor = dynamic(
  () => import("@ckeditor/ckeditor5-react").then((mod) => mod.CKEditor),
  {
    ssr: false,
  }
);

export default function Index() {
  const [value, setValue] = useState("");
  const [value1, setValue1] = useState("");

  let [loaded, setLoaded] = useState(false);

  useEffect(() => {
    setLoaded(true);
  }, []); // run on mounting

  function handleChange(text: string) {
    console.log(text);
    setValue(text);
  }

  function showValue() {
    console.log("value of the first element is ", value);
    console.log("value of the second element is ", value1);
  }

  return (
    <>
      <div></div>
      <ReactQuill
        theme="snow"
        value={value}
        onChange={handleChange}
        // modules={}
      />
      <div>Second componenet</div>
      {loaded ? (
        <CKEditor
          editor={ClassicEditor}
          data="<p>Hello from CKEditor 5!</p>"
          onReady={(editor) => {
            // You can store the "editor" and use when it is needed.
            console.log("Editor is ready to use!", editor);
          }}
          onChange={(event, editor: any) => {
            // do something when editor's content changed
            const data = editor.getData();
            setValue1(data);
            console.log({ event, editor, data });
          }}
          onBlur={(event, editor) => {
            console.log("Blur.", editor);
          }}
          onFocus={(event, editor) => {
            console.log("Focus.", editor);
          }}
        />
      ) : (
        <div>Editor is Loading</div>
      )}

      <button onClick={showValue}></button>
    </>
  );
}
