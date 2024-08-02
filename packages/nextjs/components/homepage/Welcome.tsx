import React from "react";

const Welcome = () => {
  return (
    <div className="md:text-base text-[0.8rem] border rounded-xl p-4 text-center">
      <h1 className="font-bold font-typo-round md:text-2xl text-xl ">BuidlGuild Node Streams</h1>
      <p>
        We&apos;re funding BuidlGuidl members for building and maintaining our Nodes program. We are creating scripts to
        quickly create and monitor nodes, building and shipping synced nodes to underserved areas, and providing RPC
        access.
      </p>
    </div>
  );
};

export default Welcome;
