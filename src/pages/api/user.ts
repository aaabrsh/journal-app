import type { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method === "GET") {
    const users = await prisma.user.findMany();
    res.status(200).json(users);
  } else if (req.method === "POST") {
    const postData = req.body;
    const user = await prisma.user.create({
      data: { ...postData },
    });
    res.status(201).json(user);
  } else if (req.method === "PUT") {
    const putData = req.body;
    const user = await prisma.user.update({
      where: { id: putData.id },
      data: { ...putData },
    });
    res.status(200).json(user);
  } else if (req.method === "DELETE") {
    const { id } = req.query;
    await prisma.user.delete({
      where: { id: id?.toString() },
    });
    res.status(204).end();
  } else {
    res.status(405).json({ message: "Method Not Allowed" });
  }
}
