const Welcome = () => {
  return (
    <div className="md:text-base text-[0.8rem] border rounded-xl p-4 text-center">
      <h1 className="font-bold font-typo-round md:text-2xl text-xl ">BuidlGuild Node Streams</h1>
      <p>
        We&apos;re funding BuidlGuidl members for creating and maintaining the
        <p>
          <a href="https://client.buidlguidl.com">
            <button className="btn btn-primary btn-lg" type="button">
              BuidlGuidl Node Client
            </button>
          </a>
        </p>
        a one line command to deploy and monitor an Ethereum Node. We are also building and shipping fully synced nodes
        to underserved areas around the world.
      </p>
    </div>
  );
};

export default Welcome;
