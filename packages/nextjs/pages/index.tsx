import React from "react";
import Link from "next/link";
import type { NextPage } from "next";
import { StreamContractInfo } from "~~/components/StreamContractInfo";

const Home: NextPage = () => {
  return (
    <>
      <div className="max-w-3xl px-4 py-8">
        {/* <h1 className="text-4xl font-bold mb-8 text-primary-content bg-primary inline-block p-2">Nodes</h1> */}
        <div>
          <p className="mt-0">
            Funding members for creating and maintaining the{" "}
            <Link href="https://client.buidlguidl.com/" className="link link-primary text-xl">
              BuidlGuidl Node Client
            </Link>{" "}
            a one line command to deploy and monitor an Ethereum Node. We are also building and shipping fully synced
            nodes to underserved areas around the world.
          </p>
          <Link href="/members" className="link link-primary">
            BuidlGuidl Nodes Cohort Members
          </Link>{" "}
          {/* <p>
            <
              Members
            </Link>{" "}
          </p> */}
        </div>
        <div className="mb-10">
          <StreamContractInfo />
        </div>
      </div>
    </>
  );
};

export default Home;
