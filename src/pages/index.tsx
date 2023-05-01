export default function Home() {
  return (
    <div className="home-container">
      <div className="home-bgd flex justify-center items-center">
        <div className="">
          <h1 className="text-8xl font-extrabold border-l-[20px] pl-3 mb-3 home-title">
            Welcome
          </h1>
          <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Obcaecati,
            non consequuntur voluptatem
          </p>
          <a href="#" className="home-btn">
            Get Started
          </a>
        </div>
      </div>
      <div>
        <h1>Journal Cards</h1>
        <div>Journal 1</div>
        <div>Journal 2</div>
        <div>Journal 3</div>
      </div>
      <footer>footer contacts</footer>
    </div>
  );
}
