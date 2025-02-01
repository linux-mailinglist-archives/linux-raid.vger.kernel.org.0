Return-Path: <linux-raid+bounces-3587-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D84A24BA0
	for <lists+linux-raid@lfdr.de>; Sat,  1 Feb 2025 20:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736801886D22
	for <lists+linux-raid@lfdr.de>; Sat,  1 Feb 2025 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5E1CC881;
	Sat,  1 Feb 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT8EKWph"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA0182
	for <linux-raid@vger.kernel.org>; Sat,  1 Feb 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439137; cv=none; b=SkJqLDrjXE7SC0ql9s64Pj1Cbu8cKCDqv0sPgZv+H1M+OmX2xQxBxRkOWIosa5xsLJY2RkQJCz4bxIBjLKA6KZsaAHnkxl29F2J8zc7Qx+uYW+O9B1yUPAqe3E0pzMqT9CTbdmkrTGoOvpZrqWWVomKnurvLrydFclf/USVvWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439137; c=relaxed/simple;
	bh=X0qZ2WRdxjnUm1NzAHL3QPho3z6oECh7OEFvjp81W6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AHe7DL2paA20SkPN4q4x/YR0eg9jp2GVJ3Puo6qCNLfDZY0BT6YfHKG20l85yzxRPDha7OAe60M+8bcmzoHxUkpbS+V7cfhKg5bTERzrGVMM2NjAOTHiVSNAH3Dkssql74CmZNIi9vtAMldDg1+CT5cSRwf8aluGWjGuvuZIp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT8EKWph; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efe4324f96so17712387b3.1
        for <linux-raid@vger.kernel.org>; Sat, 01 Feb 2025 11:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738439134; x=1739043934; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFC0xkjQcyYIabSSgZqu/rJ++cWg2FHeQHqKbCEZUxM=;
        b=HT8EKWphNlv+SgR1gN6++JXFz/QbjzGbIEXARNgBdmM/j4Utovb4peZPwxT08QgxiT
         yKY/Z++VMjHq2G0TmSpG+4mBIwLa6FhV/Cnp8lULBP1jDtAfkwJBaGWtQpQkVHTKPQ5p
         hjUmJ3B1PnTl8VSsG8z8iIg9k1v1eFMNzwB83wCoBTZF/g41Sum7OXLtylisN19B+rXd
         iSEsSYISMja8+++NYfIkod32VaoIfZGyVVDOZS3x5w5EjxIZduA6vzwsFk8ujzMV2PsW
         p2bUPMEQlVEmcjQnary9X/vtnLAXqQfygtiWQTU/s9zHGcsYcJGhpoqNdUyPf2cbBD8T
         MwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738439134; x=1739043934;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFC0xkjQcyYIabSSgZqu/rJ++cWg2FHeQHqKbCEZUxM=;
        b=AmGg7Z9IkyppkLreyC0qadGzx2rEMQNhRaMvQVHERoRun3zk27j4qK2imC1rNadGzL
         tD2Ld6FQEhF4SreE82XB1VMtofV6hTQD46NwuKERpW0sFqjaKi10kfdj1MC0ozrSmTxD
         2Oy5GHrAAL9Nh3bqnM6GQyFGfAfH821yXmPNXzaVxo11RfQvVnSzcGWVytQZarO9C/j7
         OTuSqRuwgWAu9DF9o+AaeLaZGrERGSIcSZcc5damLR3ioRg8gWB2Ox4rO+AXOrJbRetF
         u4s0xHVxzoATkuDcLztDm6v2fYESpnb3hSnsH+v3Z2VpUbpz64596z/oj9w5jW6ppoPQ
         NpUA==
X-Gm-Message-State: AOJu0YzLmp3ddvKcPZyrRblzNvLKQril3VRD7UOY/eSuS1/96adlsT/W
	At1+i9Cnwdgt+sBSuVMpYCYKAh9edxe9dkqb0JsB0Qhi7+oFETSIHaZRxBeUftdUmCBGoXdWsIp
	Lu/Ytdc5B35otfndbXUIQuIMDJcCtLWeX
X-Gm-Gg: ASbGnctE8FE7DGChpYb71rN7VL2VHKmeb2gE4dHLP0D5T2AFQkoMeQ1sn0Ud/g6SDD/
	qFrwAdEEqvSbuBU3tzHh+UMKbmvYepx41pTRNaNUQsfMqyb5AimhVcQRQDff6qPiugaC8GbaV7A
	==
X-Google-Smtp-Source: AGHT+IHneSRINhb3NZOBclQYC2yrq5qdWv1aycuCDd9qY4Pf7LaCt525bl901Ax0bfYxLrjIZ+OuMcXB8y6zqbp4PaI=
X-Received: by 2002:a05:690c:6201:b0:6ef:579c:38e6 with SMTP id
 00721157ae682-6f7a840332cmr124828237b3.28.1738439134394; Sat, 01 Feb 2025
 11:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sat, 1 Feb 2025 21:45:23 +0200
X-Gm-Features: AWEUYZnuSNLS17EDaZM8xcKf3R2ymUZd5Wjh7tyfLrw0zp9l8MXEI9o6y6ySryU
Message-ID: <CAAiJnjqvFAK1b26tVfzt2An1=Uxbftru7VRmVtQ55R0zH69mYA@mail.gmail.com>
Subject: mdadm/raid5, spare disk or spare space
To: linux-raid@vger.kernel.org, Song Liu <song@kernel.org>, yukuai3@huawei.com, 
	Shushu Yi <firnyee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi

Here is raid5 setup during build time

    Number   Major   Minor   RaidDevice State
       0     259        3        0      active sync   /dev/nvme3n1
       1     259        4        1      active sync   /dev/nvme4n1
       3     259        5        2      spare rebuilding   /dev/nvme5n1

       4     259        6        -      spare   /dev/nvme6n1
       5     259        7        -      spare   /dev/nvme7n1

I'm asking because during build time according to iostat or sar,
writes occurs only on /dev/nvme5n1 and never on /dev/nvme3n1 and
/dev/nvme4n1.

So if parity is distributed in mdadm/raid5, why mdadm writes only on
/dev/nvme5n1 ?

