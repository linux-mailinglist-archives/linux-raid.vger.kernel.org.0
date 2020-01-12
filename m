Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6191386AD
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgALNm2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 08:42:28 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:37525 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732912AbgALNm2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Jan 2020 08:42:28 -0500
Received: by mail-io1-f50.google.com with SMTP id k24so6799152ioc.4
        for <linux-raid@vger.kernel.org>; Sun, 12 Jan 2020 05:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jzSMe5px7cJl60kAVrg644u+ZvGoArzfvAK8BusG+ag=;
        b=XD9SS/gKbmI1nzZBlpCOZFDVRuTpRzDZKckj7W4NwOSBBYfDRQGvByBsTx/+0jpF/9
         Ugv+MkBAzwVMt15l6h5FIHiYvbQQVsNmASGj6uY+BUEniaITfF0BL9o+lLjkwALHFhba
         y+ckVy9MsyTYJNkb34a4+yy0jKADCh+yNmiMejEndW1uH+xYeavnoqPE+lvNoVi199xV
         zyLpvjLVGLIjdfnFQ2FP6Fr0ylGkz2QKUXDH/UrrFTF31ELaw3OO+PM7c58o5pKkywA5
         TWyGxpja6yKJbsmBQdGsBD9ALknjGDVWEd7Hm509Fjea7yYbpimdRmU5B/J9UhDVJMGp
         LPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jzSMe5px7cJl60kAVrg644u+ZvGoArzfvAK8BusG+ag=;
        b=M9ncmcjFk2C8pvT8ls3dM45rPVMIPh7c9HAGdeoP2hW300EbQnZ/Bx8bXlQwFetNKY
         fXiz/Y2b/riIk4ynShhCNQHb/dPFjc3twc4bp1u07oqUB+FtFgbKgCO5KRMuTp96C2wm
         qPg4QUM1r66qB3owZhzaLMaQ32taJK33ic1T2azbAudqfk2AS1syz5ne+iOR3zr3UBEB
         oP8sOKUKfdINTWwgTHAKto4Ff0ntu0C/+yqE9bsz4ZGBcQx81YODv91iB4vQwaeUN2ip
         0BxmhB9rHMJtsthjiE8G/LU5Z9RMpA4Pz8Lr/gIx85OdxPPrPid0pVvmHOZac2DjCYzG
         78dw==
X-Gm-Message-State: APjAAAVAuIaUuPeiV0qqwf+zazNUnMzC3Z99zaUdn3j+sT6LX/AMWpCj
        Y8rgXLR78UUgbwt9XO7N1wglfssLVBrPmD+w50hHRpz54ws=
X-Google-Smtp-Source: APXvYqzV8V7BrigEgPC2Sy54jMbf95jo1qdOYhio0AWV/CiTaPSGio4BDGsDGwztyvdpGQZShC9mw/g3ZSw7hC6DccY=
X-Received: by 2002:a5e:8f41:: with SMTP id x1mr9845631iop.113.1578836547665;
 Sun, 12 Jan 2020 05:42:27 -0800 (PST)
MIME-Version: 1.0
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sun, 12 Jan 2020 14:42:16 +0100
Message-ID: <CAJH6TXhnkB10BUENn0P+qXy4nunwY6QVtgDvaFVpfGDpvE-V=Q@mail.gmail.com>
Subject: dm-integrity
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I'm testing dm-integrity.
Simple question: when corrupted data are found, repair is done
immediately or on next scrub?

This is what I have:

[ 6727.395808] md: data-check of RAID array md0
[ 6727.528589] device-mapper: integrity: Checksum failed at sector 0xe228
[ 6727.938689] md: md0: data-check done.
[ 6749.125075] md: data-check of RAID array md0
[ 6749.664269] md: md0: data-check done.

if repair is done immediatly, would be possible to add a single log
line saying that ?
something like:
[ 6727.528589] md: md0: Repaired data at sector 0xe228
