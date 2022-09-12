Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D15B618B
	for <lists+linux-raid@lfdr.de>; Mon, 12 Sep 2022 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiILTPB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 12 Sep 2022 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiILTO6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 12 Sep 2022 15:14:58 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92A13F87
        for <linux-raid@vger.kernel.org>; Mon, 12 Sep 2022 12:14:56 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9E3FEE607E; Mon, 12 Sep 2022 15:08:53 -0400 (EDT)
References: <CAJJqR20U=OcMq_8wBMQ5xmWmcBcYoKN5+Fe9sPHYPkZ_yHurQQ@mail.gmail.com>
 <e8b44f4a-b6ae-6912-1b26-f900a24204af@turmel.org>
 <CAJJqR209OzydScj2jScKvKBR=B6d5JErfaFg=4qcSuC7aEvHEg@mail.gmail.com>
 <CAJJqR22EWec7gMwtVZCxxWc4-w9fEp8jaHWmtENwsLYSi7G5PQ@mail.gmail.com>
 <df503250-7c8e-d6f7-21fd-2fe4f1cae961@turmel.org>
 <CAJJqR231QRUexo=eqi=ijF+ErT=LZHr7DxWPAqC+RqF51ehmxw@mail.gmail.com>
 <CAJJqR22XEbkzF1wfO_RrnVV01E25q_OBHGdDOyBzOcGfUSwadg@mail.gmail.com>
 <CAJJqR23vGGpL-QRGKi-ft6X4RWWF0SPWJEEa=TPuo1zRnHPS3A@mail.gmail.com>
 <593e868a-d0a4-3ad5-d983-e585607ec212@turmel.org>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Phil Turmel <philip@turmel.org>
Cc:     Luigi Fabio <luigi.fabio@gmail.com>, linux-raid@vger.kernel.org
Subject: Re: RAID5 failure and consequent ext4 problems
Date:   Mon, 12 Sep 2022 15:06:47 -0400
In-reply-to: <593e868a-d0a4-3ad5-d983-e585607ec212@turmel.org>
Message-ID: <87k0688l6i.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Phil Turmel <philip@turmel.org> writes:

> Yes.  Same kernels are pretty repeatable for device order on bootup as
> long as all are present.  Anything missing will shift the letter 
> assignments.

Every time I think about this I find myself amayzed that it does seem to
be so stable, and wonder how that can be.  The drives are all enumerated
in paralell these days so the order they get assigned in should be a
total crap shoot, shouldn't it?

