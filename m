Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA381089DC
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 09:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKYIQa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 03:16:30 -0500
Received: from mail.iankelling.org ([72.14.176.105]:45694 "EHLO
        mail.iankelling.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIQa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 Nov 2019 03:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iankelling.org; s=li; h=MIME-Version:Date:In-reply-to:Subject:To:From:
        References; bh=ivIOHBuCmVTRV4cJ1cLCT1TzgTwGmhp2NJgeICexL9k=; b=AVsUva2ceCpJ01
        7GfN+Me6HcaPHqI+lMAcx90HtzufMGnD8BuOnx7DKj1+6s8QNfUPCxXRZkqBmeaDJWq+/D79bw69P
        /NfLgb+JF/sXFF371F95UD14SP336FGrYUNmqLW3lWX7oJkxAPAVD9v8tfrBxE58fjkRCwwhWPq2F
        HFVMO6MMGfmSv/984evEu/U0wd7sgz1ZhU4RvjfiUXdFau46XBf4hPiWFxk/3ClsGWSY92EricRdr
        0PHwYx7Z6/rXnSyEQ9rymTxj4/l70WmFiRDJR9IFm4Yr9cmtlKZ4JmvO+u/QTjXPHLX0s/DAsaF2K
        f0BfHjHHpNoWB0Jmw4jA==;
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
        (envelope-from <ian@iankelling.org>)
        id 1iZ9Xo-0008PZ-RV; Mon, 25 Nov 2019 03:16:28 -0500
References: <3fc5f3df-0589-645c-f36a-2eee83e8bccd () gnu ! org>
 <871rtw5z9e.fsf@fsf.org> <87zhgk4d4r.fsf@iankelling.org>
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Ian Kelling <ian@iankelling.org>
To:     Ian Kelling <iank@fsf.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Deep into potential data loss issue
In-reply-to: <87zhgk4d4r.fsf@iankelling.org>
Date:   Mon, 25 Nov 2019 03:16:28 -0500
Message-ID: <87y2w44bhf.fsf@iankelling.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Ian Kelling <ian@iankelling.org> writes:

> The partitions showed up, but the filesystems are full of errors and
> generally unusable.

update: I ran mdadm --create again with a different device ordering and
that seems to have fixed the problem.
